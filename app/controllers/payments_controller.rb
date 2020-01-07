class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.where(state: 'Non finalisée').find(params[:order_id])
  end
end
