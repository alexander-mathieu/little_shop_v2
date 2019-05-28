class Admin::OrdersController < Admin::BaseController
  def index

  end

  def ship
    order = Order.find(params[:order_id])
    order.ship

    flash[:notice] = "Order #{order.id} shipped!"

    redirect_to admin_dashboard_path
  end
end
