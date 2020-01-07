class OrdersController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    product = Product.find(params[:product_id])
    order = Order.new(order_params)
    order.product = product
    order.product_name = product.name
    order.amount = product.price
    order.state = 'Non finalisée'
    order.user = current_user
    if order.save

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: "#{order.address}, #{order.zipcode}, #{order.city}",
        images: [product.photo_url],
        amount: product.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
    else
      redirect_to new_product_order_path(product)
      flash[:alert] = "Something went wrong..."
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @orders = current_user.orders
  end

  def order_params
    params.require(:order).permit(:address, :city, :zipcode)
  end
end
