class Profile::OrdersController < ApplicationController
  def index
  end

  def create
    order = Order.new user_id: current_user.id, status: 0
    order.save
    @cart = Cart.new(session[:cart])
    items = @cart.items
    items.each do |item, quantity|
      order_item = OrderItem.new item_id: item.id, order_id: order.id,
        quantity: quantity, price: (item.price * quantity)
      order_item.save
    end
    session[:cart] = nil

    flash[:success] = "Order has been placed."
    redirect_to profile_orders_path
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.update(status: 3)
    @order.cancel_items
    flash[:message] = "Order #{@order.id} cancelled."
    redirect_to(profile_path)

  end
end
