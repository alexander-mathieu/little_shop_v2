class Admin::UsersController < Admin::BaseController
  def index
    @default_users = User.find_default_users
  end
end
