class Merchants::ItemsController < ApplicationController
  def index
    if params[:id]
      @merchant = User.find(params[:id])
    else
      @merchant = current_user
    end

    @dashboard = @merchant == current_user || current_admin? ? true : false

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
