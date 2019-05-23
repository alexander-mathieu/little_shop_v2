class MerchantsController < ApplicationController
  def index
    @merchants = User.find_merchants
  end

  def show
    
  end
end
