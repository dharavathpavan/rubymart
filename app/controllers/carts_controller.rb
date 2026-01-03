class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :add_item, :remove_item, :update_item]

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def add_item
    @product = Product.find(params[:product_id])
    @cart = current_user.cart || current_user.create_cart
    @cart.add_product(@product).save
    redirect_to cart_path, notice: 'Item added to cart'
  end

  def remove_item
    @cart_item = current_user.cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed'
  end

  def update_item
    @cart_item = current_user.cart.cart_items.find(params[:id])
    if @cart_item.update(quantity: params[:quantity])
      redirect_to cart_path, notice: 'Cart updated'
    else
      redirect_to cart_path, alert: 'Could not update cart'
    end
  end
end
