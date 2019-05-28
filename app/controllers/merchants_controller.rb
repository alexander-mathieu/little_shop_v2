class MerchantsController < ApplicationController
  def index
    @merchants = User.find_merchants
    @merchants_top_three_revenue = User.top_three_revenue
    @merchants_quickest_fulfillments = User.top_three_fulfillments("asc")
    @merchants_slowest_fulfillments = User.top_three_fulfillments("desc")
    @merchants_top_three_states = User.top_three_orders_by("state")
    @merchants_top_three_cities = User.top_three_orders_by("city")
    @top_three_orders = Order.top_three_order_item_quantity
  end

  def show
    @merchant = current_user
    @merchant_orders = @merchant.pending_orders
    @merchant_top_five_items_sold = @merchant.top_five_sold
    @merchant_total_quantity_items_sold = @merchant.total_quantity_items_sold
    @merchant_total_percentage_inventory_sold = @merchant.total_percentage_inventory_sold
    @items = current_user.items
    render file: "app/public/404.html" unless @merchant.merchant? || @merchant.admin?
  end
end
