class MerchantsController < ApplicationController
  def index
    @merchants = User.find_merchants
  end
end
