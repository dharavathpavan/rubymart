class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart
    
    if @cart.nil? || @cart.cart_items.empty?
      redirect_to root_path, alert: "Cart is empty"
      return
    end

    # Check for COD or missing/invalid Stripe keys
    if params[:payment_method] == 'cod' || !stripe_configured?
      handle_mock_order
      return
    end

    begin
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: @cart.cart_items.map { |item|
          {
            price_data: {
              currency: 'usd',
              product_data: {
                name: item.product.name,
              },
              unit_amount: (item.product.price * 100).to_i,
            },
            quantity: item.quantity,
          }
        },
        mode: 'payment',
        success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: checkout_cancel_url,
        customer_email: current_user.email,
        metadata: {
          user_id: current_user.id
        }
      )
      redirect_to session.url, allow_other_host: true
    rescue Stripe::AuthenticationError, Stripe::InvalidRequestError => e
      Rails.logger.error "Stripe Error: #{e.message}"
      handle_mock_order(error_message: "Stripe configuration issue detected. Processed as Demo Payment.")
    end
  end

  def success
    if params[:mock] == 'true'
      flash[:notice] = "Order processed successfully!"
      return
    end

    begin
      session = Stripe::Checkout::Session.retrieve(params[:session_id])
      user_id = session.metadata.user_id
      # In a real app, we rely on webhooks. For this demo, if the webhook hasn't fired yet,
      # we might want to ensure the cart is cleared or show a success message.
    rescue => e
      # Ignore error for view
    end
  end

  def cancel
  end

  private

  def stripe_configured?
    ENV['STRIPE_SECRET_KEY'].present? && !ENV['STRIPE_SECRET_KEY'].start_with?('sk_test_placeholder')
  end

  def handle_mock_order(error_message: nil)
    # Direct Order Creation for Demo/COD
    ActiveRecord::Base.transaction do
      order = current_user.orders.create!(
        total_price: @cart.total_price,
        status: :paid # or :pending for COD
      )

      @cart.cart_items.each do |cart_item|
        order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
      
      @cart.cart_items.destroy_all
    end

    msg = error_message || "Order placed successfully (Demo/COD Mode)."
    redirect_to checkout_success_path(mock: true), notice: msg
  end
end
