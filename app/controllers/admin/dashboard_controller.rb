class Admin::DashboardController < Admin::BaseController
  def index
    orders = Order.all
    @orders = orders.admin_dashboard_sort
  end
end
