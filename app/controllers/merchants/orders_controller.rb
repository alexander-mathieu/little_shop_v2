class Merchants::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def fulfill
    order = Order.find(params[:id])
    order_item = OrderItem.find(params[:order_item])
    item = order_item.item
    order_item.update!(fulfilled: true)
    order_item.item.update!(inventory: (item.inventory - order_item.quantity))
    flash[:message] = "Fulfilled item #{order_item.item.name} of this order"
    redirect_to merchant_order_path(order)
  end
end
