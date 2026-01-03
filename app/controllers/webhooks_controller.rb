class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  skip_before_action :set_cart

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      status 400
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      handle_checkout_session_completed(session)
    end

    render json: { message: 'success' }
  end

  private

  def handle_checkout_session_completed(session)
    user_id = session.metadata.user_id
    user = User.find_by(id: user_id)
    return unless user

    # Create Order
    cart = user.cart
    return unless cart

    order = user.orders.create!(
      total_price: cart.total_price,
      status: :paid
    )

    # Move items
    cart.cart_items.each do |cart_item|
      order.order_items.create!(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    # Clear Cart
    cart.cart_items.destroy_all
    
    # Send Email (Mock)
    # OrderMailer.with(order: order).confirmation_email.deliver_later
  end
end
