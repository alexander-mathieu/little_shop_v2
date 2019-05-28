class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
    @dashboard = @merchant == current_user ? true : false
    @merchant_orders = @merchant.pending_orders
    @top_five_items_sold = @merchant.top_five_sold

    if @merchant.default?
      redirect_to admin_user_path(@merchant)
    end

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

  def enable
    User.update(params[:id], active: true)
    flash[:note] = "Merchant has been enabled."
    redirect_to "admin/dashboard#merchant-#{params[:id]}"
  end

  def disable
    User.update(params[:id], active: false)
    flash[:note] = "Merchant has been disabled."
    redirect_to "admin/dashboard#merchant-#{params[:id]}"
  end

  def downgrade
    merchant = User.find(params[:merchant_id])
    merchant.deactivate_all_items
    merchant.downgrade_to_user

    flash[:notice] = "#{merchant.name} has been downgraded to a User."

    redirect_to admin_user_path(merchant)
  end
end
