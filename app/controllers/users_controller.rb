class UsersController < ApplicationController
  before_action :current_user,  only: :show

  def new
  end

  def show
    render file: "app/views/users/new.html.erb" if current_user.nil?
    @user = User.find(params[:id])
  end
end
