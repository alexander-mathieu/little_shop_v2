class MerchantsController < ApplicationController
  def index
    @merchants = User.find_merchants
  end

  def show
    @user = current_user
    render file: "app/public/404.html" unless @user.merchant?
    
  end
end
