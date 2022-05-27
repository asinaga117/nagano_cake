class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    
    @cart_item = CartItem.new
  end
  
  private
  def items_params
    parmas.require(:item).permit(:genle_id, :name, :introduction, :price, :is_active, :image_id)
  end
end
