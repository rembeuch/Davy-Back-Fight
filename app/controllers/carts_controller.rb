class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show]

  def show
  end

  def destroy
    @cart = current_user.cart
    @cart.items.destroy_all
    redirect_to cart_path(@cart)
  end
end
