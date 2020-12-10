class OrdersController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    product = Product.find(params[:product_id])
    order = Order.new(order_params)
    order.product = product
    if order.upsell == true
      order.product_name = "#{product.name} +  #{Product.first.name}"
      order.amount = ((product.price * order.quantity) + Product.first.price)
    else
      order.product_name = product.name
      order.amount = (product.price * order.quantity)
    end
    order.state = 'Non finalisée'
    order.user = current_user

    if order.save && order.quantity >= 1

      if order.coupon == ""
        order.amount
      elsif order.coupon == "JUBA10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "OPNOMI10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "DANN10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "MANGASFRS"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "SHANKSHAKI"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "EMD178"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "mugiwara10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "KAIZOKUKU"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "FOXY10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "Onepiece7"
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
          name: "Code PROMO: #{order.coupon} /Nom: #{order.name} / Adresse de livraison: #{order.address}, #{order.zipcode}, #{order.city}, #{order.nation} / #{order.product_name}",
          images: [product.image],
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
    if @order.state == "paid" && @order.mailing == true
      @order.update(mailing: false)
    end
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
    if order.upsell == true
      order.update(product_name: "#{@product_list.join(' ')} + #{Product.first.name}")
      order.update(amount: (@cart.total + Product.first.price))
    else
      order.update(product_name: @product_list.join(' '))
      order.update(amount: @cart.total)
    end
    order.state = 'Non finalisée'

    if order.save && order.quantity == 1
      if order.coupon == ""
        order.amount
      elsif order.coupon == "JUBA10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "OPNOMI10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "DANN10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "MANGASFRS"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "SHANKSHAKI"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "EMD178"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "mugiwara10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "KAIZOKUKU"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "FOXY10"
        @coupon = Stripe::Coupon.retrieve("#{order.coupon}")
        order.amount -= (order.amount * (@coupon.percent_off / 100))
      elsif order.coupon == "Onepiece7"
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
          name: "Code PROMO: #{order.coupon} /Nom: #{order.name} / Adresse de livraison: #{order.address}, #{order.zipcode}, #{order.city}, #{order.nation} / #{order.product_name} ",
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

  def upsell
    @order.upsell = true
  end

  def order_params
    params.require(:order).permit(:name, :address, :city, :zipcode, :nation, :quantity, :coupon, :upsell)
  end
end
