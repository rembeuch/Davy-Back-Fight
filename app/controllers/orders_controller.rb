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
    order.amount = (product.price * order.quantity)
    order.state = 'Non finalisée'
    order.user = current_user

    if order.save && order.quantity >= 1

      if order.coupon == ""
        order.amount
      elsif order.coupon == "DVBF10"
        Stripe::Coupon.retrieve("#{order.coupon}")
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      else
        order.amount
        order.coupon = ""
        flash[:alert] = "Wrong Code Promo"
      end

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: "Code PROMO: #{order.coupon} /Nom: #{order.name} / Adresse de livraison: #{order.address}, #{order.zipcode}, #{order.city}, #{order.nation} / #{product.name}",
          images: [product.photo],
          amount: order.amount_cents.to_i / order.quantity,
          currency: 'eur',
          quantity: order.quantity,
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

  def items_order
    @cart = current_user.cart
    @order = Order.new
  end

  def items_order_create
    @cart = current_user.cart
    order = Order.new(order_params)
    order.user = current_user
    @product_list = []
    @cart.items.each do |item|
      @product_list.push(item.quantity)
      @product_list.push(item.product.name)
    end
    order.product = @cart.items.first.product
    order.update(product_name: @product_list.join(' '))
    order.update(amount: @cart.total)
    order.state = 'Non finalisée'

    if order.save && order.quantity == 1
      if order.coupon == ""
        order.amount
      elsif order.coupon == "DVBF10"
        Stripe::Coupon.retrieve("#{order.coupon}")
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount = @cart.total
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      else
        order.amount
        order.coupon = ""
        flash[:alert] = "Wrong Code Promo"
      end

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: "Code PROMO: #{order.coupon} /Nom: #{order.name} / Adresse de livraison: #{order.address}, #{order.zipcode}, #{order.city}, #{order.nation} / #{@product_list.join(' ')} ",
          amount: order.amount_cents.to_i,
          currency: 'eur',
          quantity: order.quantity,
        }],
        success_url: order_url(order),
        cancel_url: order_url(order)
      )

      order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(order)
    else
      redirect_to cart_path(@cart)
      flash[:alert] = "Something went wrong..."
    end
  end

  def order_params
    params.require(:order).permit(:name, :address, :city, :zipcode, :nation, :quantity, :coupon)
  end
end
