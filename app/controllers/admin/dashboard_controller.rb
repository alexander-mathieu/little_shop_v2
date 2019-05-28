class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def show
    @user = User.find(params[:id])
  end
end
