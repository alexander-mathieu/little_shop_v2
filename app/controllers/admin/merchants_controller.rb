class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
    @items = @merchant.items
    @merchant_orders = @merchant.pending_orders
    @top_five_items_sold = @merchant.top_five_sold
    render file: "/app/views/merchants/show.html", status: 200
  end

  def enable
    Item.update(params[:id], active: true)
    flash[:note] = "Merchant has been enabled."
    redirect_to "admin/dashboard#merchant-#{params[:id]}"
  end

  def disable
    Item.update(params[:id], active: false)
    flash[:note] = "Merchant has been disabled."
    redirect_to "admin/dashboard#merchant-#{params[:id]}"
  end
end
