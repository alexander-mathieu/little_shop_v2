class Admin::UsersController < Admin::BaseController
  def index
    @default_users = User.find_default_users
  end

  def show
    @user = User.find(params[:id])
  end
end
