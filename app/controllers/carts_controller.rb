class CartsController < ApplicationController
  def create
    adding = Item.find(params[:item_id])
    session[:cart] ||= Hash.new(0)
    session[:cart][adding] ||= 0
    session[:cart][adding] += 1
    session[:cart][:cart_total_items] += 1
    #flash for
    redirect_to items_path
  end

  def show
    @cart = session[:cart] == nil ? :empty : session[:cart].sort_by {|k,v| k}
  end
end