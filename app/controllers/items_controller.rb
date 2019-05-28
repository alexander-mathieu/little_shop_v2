class ItemsController < ApplicationController
  def index
    i = 0
    @items_left = []; @items_mid = []; @items_right = []
    Item.all.each do |item|
      case i
      when 0; @items_left << item
      when 1; @items_mid << item
      when 2; @items_right << item
      end
      i += 1; i = 0 if i > 2
    end
    @most_popular = Item.most_popular
    @least_popular = Item.least_popular
  end

  def show
    @item = Item.find(params[:id])
    @average_fulfillment_time = @item.average_fulfillment_time
  end

  def new
    @merchant = current_user
    @item = Item.new
  end

  def create
    adding = current_user.items.create(item_params)
    if adding.save
      flash[:note] = "Item Added."
      redirect_to "/dashboard##{adding.id}"
    else
      flash[:warn] = "Invalid input."
      redirect_to new_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])    
  end

  def update
    if Item.find(params[:id]).update(item_params)
      flash[:note] = "Item updated."
      redirect_to '/dashboard'
    else
      flash[:warn] = "Input invalid."
      redirect_to edit_item_path
    end
  end

  def enable
    Item.update(params[:id], active: true)
    flash[:note] = "Item has been enabled."
    redirect_to "/dashboard#item-#{params[:id]}"
  end

  def disable
    Item.update(params[:id], active: false)
    flash[:note] = "Item has been disabled."
    redirect_to "/dashboard#item-#{params[:id]}"
  end

  def destroy
    Item.destroy(params[:id])
    flash[:note] = "Item has been deleted."
    redirect_to '/dashboard'
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :inventory)
  end
end
