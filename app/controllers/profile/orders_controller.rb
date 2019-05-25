class Profile::OrdersController < ApplicationController

  def index

  end

  def show
  end

  def destroy
    @order = Order.find(params[:id])
    @order.cancel_items

  end
end
