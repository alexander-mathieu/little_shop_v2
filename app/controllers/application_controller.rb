class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_is_merchant?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_is_merchant?
     current_user.role == 1
   end
end
