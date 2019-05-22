class SessionsController < ApplicationController
  def new
  end

  def create
    if @current_user
      if @current_user.admin?
        #redirect_to admin_dash_path(@current_user)
      elsif @current_user.merchant?
        #redirect_to merch_dash_path(@current_user)
      else
        redirect_to user_path(@current_user)
      end
    else
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        flash[:warn] = "Some of your information isn't correct."
        render :new
      end
    end

  end

  def delete
    session[:user_id] = nil
    flash[:message] = "You are now logged Out"
    redirect_to root_path
  end
end
