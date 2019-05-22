class ItemsController < ApplicationController
  def index
    @items = Item.all
    @most_popular = @items.most_popular
    @least_popular = @items.least_popular
  end

  def show
    @item = Item.find(params[:id])
  end
end
