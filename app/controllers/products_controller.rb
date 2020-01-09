class ProductsController < ApplicationController
skip_before_action :authenticate_user!

def index
  @products = Product.all
end

def show
  @product = Product.find(params[:id])
end

def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def product_params
    params.require(:product).permit(:name, :photo, :price_cents, :description)
  end
end
