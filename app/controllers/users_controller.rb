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

  def show
    if current_user.nil?
    @user = User.new
    render file: "app/views/users/new.html.erb"
  else
    @user = current_user
  end
  end

  def edit
    @user = current_user
  end


  def update
    if User.find_by(email: params[:user][:email])
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
