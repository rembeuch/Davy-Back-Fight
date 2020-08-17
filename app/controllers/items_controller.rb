class ItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    product = Product.find(params[:product_id])
    @item = @cart.add_product(product)

    if @item.save
      redirect_to cart_path(@cart)
    else
      redirect_to product_path(product)
    end
  end

  def destroy
    @cart = current_user.cart
    @item = Item.find_by(id: params[:check])
    @item.destroy
    redirect_to cart_path(@cart)
  end

  def add_item
    @cart = current_user.cart
    @item = Item.find_by(id: params[:check])
    @item.update(quantity: (@item.quantity += 1))
    redirect_to cart_path(@cart)
  end

  def sub_item
    @cart = current_user.cart
    @item = Item.find_by(id: params[:check])
    if @item.quantity > 1
      @item.update(quantity: (@item.quantity -= 1))
    else
      @item.quantity == 1
    end
    redirect_to cart_path(@cart)
  end
end
