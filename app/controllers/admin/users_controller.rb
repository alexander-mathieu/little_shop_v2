class Admin::UsersController < Admin::BaseController
  def index
    @default_users = User.find_default_users
  end

  def show
    @user = User.find(params[:id])

    redirect_to merchant_path(@user) if @user.merchant?
  end

  def upgrade
    user = User.find(params[:user_id])
    user.upgrade_to_merchant

    flash[:notice] = "#{user.name} has been upgraded to a Merchant."

    redirect_to merchant_path(user)
  end
end
