class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.where(state: 'Non finalisée').find(params[:order_id])
           UserMailer.with(user: current_user).command.deliver_now
  end
end
