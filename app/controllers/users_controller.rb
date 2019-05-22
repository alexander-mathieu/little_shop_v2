class UsersController < ApplicationController
  before_action :current_user,  only: :show

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:message] = "Welcome, #{user.name}. You are now registered and logged in!"
      # change path to profile_path
      redirect_to root_path
    else
      @user = User.new(user_params)
      flash[:error] = "You are missing required fields, your email is already in use, or your passwords don't match."
      render :new
    end
  end

  def show
    @user = User.new
    render file: "app/views/users/new.html.erb" if current_user.nil?
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end
  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

end
