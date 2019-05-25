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
    @user = current_user
    @items = Item.where("user_id = #{current_user.id}")
  end
end
