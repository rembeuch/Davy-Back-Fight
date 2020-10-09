class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :tags_product ]
  def index
    @products = Product.all
    @article = Article.first
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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product), notice: 'modifié!'
    else
      render :edit
    end
  end

  def tags_product
    @product = Product.find(params[:product_id])
    @products = Product.all
  end

  def product_params
    params.require(:product).permit(:name, :photo, :image, :price_cents, :description, :tags)
  end
end
