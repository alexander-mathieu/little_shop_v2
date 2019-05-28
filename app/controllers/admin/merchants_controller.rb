class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = User.find(params[:id])
    @items = @merchant.items
    @merchant_orders = @merchant.pending_orders
    @merchant_top_five_items_sold = @merchant.top_five_sold
    @merchant_total_quantity_items_sold = @merchant.total_quantity_items_sold
    @merchant_total_percentage_inventory_sold = @merchant.total_percentage_inventory_sold
    @merchant_top_three_states_shipped = User.top_three_states_shipped_to(@merchant)
    @merchant_top_three_cities_shipped = User.top_three_cities_shipped_to(@merchant)
    @merchant_top_orders_customer = User.top_orders_customer(@merchant)
    # @merchant_top_customer_items = User.top_customer_items(@merchant)
    render file: "/app/views/merchants/show.html", status: 200
  end

  def update
    user = User.find_by(id: params[:id])
    if params[:commit] == "enable"

      User.update(user.id,active: true)
      flash[:message] = "Merchant #{user.id} enabled"
    elsif params[:commit] == "disable"
      User.find(params[:id]).update(active: false)
      flash[:message] = "Merchant #{user.id} disabled"
    end
    redirect_to merchants_path
  end
end
