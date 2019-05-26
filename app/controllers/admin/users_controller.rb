class Admin::UsersController < Admin::BaseController
  def index
    @default_users = User.find_default_users
  end

  def show
    @user = User.find(params[:id])
  end

  def upgrade
    user = User.find(params[:user_id])
    user.upgrade_to_merchant

    flash[:notice] = "#{user.name} has been upgraded to a Merchant."

    redirect_to admin_merchant_path(user)
  end
end
