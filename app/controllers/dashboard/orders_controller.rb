class Dashboard::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
end
