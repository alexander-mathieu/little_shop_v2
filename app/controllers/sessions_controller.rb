class SessionsController < ApplicationController
  def new
    if current_user
      if current_user.admin? TO ADD WHEN MERCHANT AND ADMIN DASH ARE THERE
        redirect_to admin_dash_path(@current_user)
      elsif current_user.merchant?
        redirect_to merch_dash_path(@current_user)
      else
        redirect_to profile_path
      end
    end
  end

  def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to profile_path
      else
        flash[:warn] = "Some of your information isn't correct."
        render :new
      end
  end

  def delete
    session[:user_id] = nil
    flash[:message] = "You are now logged out"
    redirect_to root_path
  end
end
