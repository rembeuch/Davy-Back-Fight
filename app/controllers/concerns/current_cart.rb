module CurrentCart
  private
  def set_cart
    if current_user.cart == nil
      @cart = Cart.create
      @cart.user = current_user
    else
      @cart = current_user.cart
    end
  end
end
