class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
