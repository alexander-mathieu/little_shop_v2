class MerchantsController < ApplicationController
  def index
    merchants = User.find_merchants
    @merchants_top_three_revenue = User.top_three_revenue
    @merchants_quickest_fulfillments = User.top_three_fulfillments("asc")
    @merchants_slowest_fulfillments = User.top_three_fulfillments("desc")
    @merchants_top_three_states = User.top_three_orders_by("state")
    @merchants_top_three_cities = User.top_three_orders_by("city")
    @top_three_orders = Order.top_three_order_item_quantity

    @merch_left = []; @merch_mid = []; @merch_right = []
    i = 0
    merchants.each do |merchant|
      case i
      when 0; @merch_left << merchant
      when 1; @merch_mid << merchant
      when 2; @merch_right << merchant
      end
      i += 1; i = 0 if i > 2
    end

    length = merchants.count
    if length > 12
      @i = (length / 6).floor
    else
      @i = -1
    end
  end

  def show
    @merchant = current_user
    @merchant_orders = @merchant.pending_orders
    @top_five_items_sold = @merchant.top_five_sold
    @items = current_user.items
    render file: "app/public/404.html" unless @merchant.merchant? || @merchant.admin?
  end
end
