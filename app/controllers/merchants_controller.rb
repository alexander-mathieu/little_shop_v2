class MerchantsController < ApplicationController
  def index
    merchants = User.find_merchants
    @merchants_top_three_revenue = User.top_three_revenue
    @merchants_quickest_fulfillments = User.top_three_fulfillments("asc")
    @merchants_slowest_fulfillments = User.top_three_fulfillments("desc")
    @merchants_top_three_states = User.top_three_orders_by_state
    @merchants_top_three_cities = User.top_three_orders_by_city_state
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
    if params[:id]
      @merchant = User.find(params[:id])
    else
      @merchant = current_user
    end
    @dashboard = @merchant == current_user || current_admin? ? true : false
    @merchant_top_five_items_sold = @merchant.top_five_sold
    @merchant_total_quantity_items_sold = @merchant.total_quantity_items_sold
    @merchant_total_percentage_inventory_sold = @merchant.total_percentage_inventory_sold
    @merchant_top_three_states_shipped = User.top_three_states_shipped_to(@merchant)
    @merchant_top_three_cities_shipped = User.top_three_cities_shipped_to(@merchant)
    @merchant_top_orders_customer = User.top_orders_customer(@merchant)
    @merchant_top_items_customer = User.top_items_customer(@merchant)
    @merchant_top_three_money_customers = User.top_three_money_customers(@merchant)

    @items_left = []; @items_mid = []; @items_right = []
    i = 0
    @merchant.items.each do |item|
      case i
      when 0; @items_left << item
      when 1; @items_mid << item
      when 2; @items_right << item
      end
      i += 1; i = 0 if i > 2
    end

    @orders_left = []; @orders_mid = []; @orders_right = []
    i = 0
    @merchant.pending_orders.each do |order|
      case i
      when 0; @orders_left << order
      when 1; @orders_mid << order
      when 2; @orders_right << order
      end
      i += 1; i = 0 if i > 2
    end
  end
end
