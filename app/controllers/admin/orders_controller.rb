class Admin::OrdersController < Admin::BaseController
  def index
    @user = User.find(params[:user_id])
    @orders = User.find(params[:user_id]).orders
  end

  def ship
    order = Order.find(params[:order_id])
    order.ship

    flash[:notice] = "Order #{order.id} shipped!"

    redirect_to admin_dashboard_path
  end
end
