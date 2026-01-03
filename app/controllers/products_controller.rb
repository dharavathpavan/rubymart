class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.active
    else
      @products = Product.active
    end
  end

  def show
    @product = Product.active.find(params[:id])
  end
end
