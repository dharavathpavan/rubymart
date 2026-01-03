class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def track
    if params[:order_id].present?
      @order = Order.find_by(id: params[:order_id])
      if @order.nil?
        flash.now[:alert] = "Order # #{params[:order_id]} not found. Please check the ID and try again."
      end
    end
  end
end
