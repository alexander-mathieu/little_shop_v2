class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user_email = user[:email]
    if user.save
      session[:user_id] = user.id
      flash[:message] = "Welcome, #{user.name}. You are now registered and logged in!"
      redirect_to profile_path
    elsif User.find_by_email(user_email) != nil
      user_params_no_email_no_pw = user_params.except(:email, :password, :password_confirmation)
      @user = User.new(user_params_no_email_no_pw)
      flash[:error] = "This email is already in use."
      render :new
    else
      user_params_no_pw = user_params.except(:password, :password_confirmation)
      @user = User.new(user_params_no_pw)
      if user_params[:password] != user_params[:password_confirmation]
        flash[:error] = "Your passwords don't match."
      else
        flash[:error] = "You are missing required fields."
      end
      render :new
    end
  end

  def show
    if current_user && !current_user.merchant?
      @user = current_user
    else
      @user = User.new
      render file: "/public/404", status: 404
    end
  end

  def edit
    @user = current_user
  end


  def update
    user = User.find_by(email: params[:user][:email])
    if user && !(user == current_user)
      flash[:message] = "That email is already in use"
      redirect_to profile_edit_path
    else
      current_user.update(user_params)
      redirect_to profile_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

end
