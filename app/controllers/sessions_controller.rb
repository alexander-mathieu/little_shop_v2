class SessionsController < ApplicationController
  def new
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
end
