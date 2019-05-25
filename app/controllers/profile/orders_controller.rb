class Profile::OrdersController < ApplicationController

  def index

  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.update(status: 3)
    @order.cancel_items
    redirect_to(profile_path)

  end
end
