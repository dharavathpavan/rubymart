class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @featured_products = Product.active.limit(4)
    @categories = Category.all
  end
end
