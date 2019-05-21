class UsersController < ApplicationController
  before_action :current_user,  only: :show

  def new
  end

  def show
    @user = User.find(params[:id])
  end
end
