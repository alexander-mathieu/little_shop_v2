class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.admin_dashboard_sort
  end

  def show
    @user = User.find(params[:id])
  end
end
