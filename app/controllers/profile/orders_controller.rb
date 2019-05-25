class OrdersController < ApplicationController
  def index
  end

  def new
        
  end

  def create
    order = Order.new user_id: @current_user.id, status: 0
    order.save
    items = @cart.items
    items.each do |item, quantity|
      order_item = OrderItem.new item_id: item.id, order_id: order.id,
        quantity: quantity, price: (item.price * quantity)
      order_item.save
    end
    @cart.empty!

    flash[:note]
    redirect_to profile_orders_path
  end

  def show
    @order = Order.find(params[:id])
  end

end
