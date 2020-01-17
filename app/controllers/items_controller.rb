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
end
