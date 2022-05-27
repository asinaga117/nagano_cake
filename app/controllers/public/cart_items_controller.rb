class Public::CartItemsController < ApplicationController
  def index
     @cart_items = CartItem.where(customer:current_customer)
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_items_params)
    @plus_cart_item = CartItem.find_by(item_id: @cart_item.item_id)
    if @plus_cart_item.present? && @cart_item.valid?
    @cart_item.amount += @plus_cart_item.amount
    @plus_cart_item.destroy
    end
    if @cart_item.save
    redirect_to public_cart_items_path
    else
    @item = Item.find(params[:cart_item][:item_id])
    @cart_item = CartItem.new
    render "public/items/show"
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_items_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private
  
  
  def cart_items_params
    params.require(:cart_item).permit(:amount, :item_id)
    
  end
end
