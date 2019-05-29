class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
    @orders.admin_dashboard_sort
  end

  def show
    @user = User.find(params[:id])
  end
end
