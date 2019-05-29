class CartsController < ApplicationController
  def create
    id = params[:item_id]
    @cart = Cart.new(session[:cart])
    if params[:quantity].class != String
      quantity = params[:quantity].keys
      quantity = quantity[0].to_i
    else
      if params[:adding] == "1"
        quantity = params[:quantity].to_i + @cart.quantity_of(id)
      else
        quantity = params[:quantity].to_i
      end
    end
    @cart.add(id, quantity)
    session[:cart] = @cart.contents
    #flash for
    redirect_back fallback_location: '/'
  end

  def show
    if current_user && (current_user.merchant? || current_admin?)
      render file: "/public/404", status: 404
    end
    @cart = Cart.new(session[:cart])
  end

  def destroy; session[:cart] = nil; redirect_to '/cart' end
end
