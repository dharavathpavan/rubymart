class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :set_cart
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  # Pundit rescue
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_cart
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
    else
      # For guest users, we would use session[:cart_id], but for simplicity in this MVP
      # we will require login for cart operations or link it later.
      # To make it "User Friendly" we can allow browsing but prompt login on Add to Cart.
      @cart = nil
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
