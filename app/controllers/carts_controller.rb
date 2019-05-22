class CartsController < ApplicationController
  def create
    id = Item.find(params[:item_id]).id.to_s
    @cart = Cart.new(session[:cart])
    @cart.add(id)
    session[:cart] = @cart.contents
    #flash for
    redirect_to items_path
  end

  def show
    @cart = Cart.new(session[:cart])
  end
end