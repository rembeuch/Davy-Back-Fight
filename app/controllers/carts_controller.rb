class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show]

  def show
    @sum_items = 0
  end

  def destroy
    @cart = current_user.cart
    @cart.items.destroy_all
    redirect_to cart_path(@cart)
    flash[:alert] = "Votre panier est vide!"
  end
end
