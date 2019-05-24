class CartsController < ApplicationController
  def create
    id = params[:item_id].keys[0].to_i #Fix for the weird form behaviour
    @cart = Cart.new(session[:cart])
    if params[:quantity].class != String
      quantity = params[:quantity].keys
      quantity = quantity[0].to_i
    else
      quantity = params[:quantity]
    end
    @cart.add(id, quantity)
    session[:cart] = @cart.contents
    #flash for
    redirect_back fallback_location: '/'
  end

  def show
    @cart = Cart.new(session[:cart])
  end

  def destroy; session[:cart] = nil; redirect_to '/cart' end
end
