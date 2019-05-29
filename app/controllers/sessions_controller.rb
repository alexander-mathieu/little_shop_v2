class SessionsController < ApplicationController
  def new
    if current_user  && current_user.active
      if current_user.admin?
        redirect_to admin_dashboard_path(current_user)
      elsif current_user.merchant?
        redirect_to dashboard_path
      else

        redirect_to profile_path
      end
    end
  end

  def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        flash.delete(:warn)
        session[:user_id] = user.id
        redirect_back fallback_location: '/'
      else
        flash[:warn] = "Some of your information isn't correct."
        render :new
      end
  end

  def delete
    session[:user_id] = nil
    flash[:note] = "You are now logged out"
    redirect_to root_path
  end
end
