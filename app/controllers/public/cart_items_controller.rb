class Public::CartItemsController < ApplicationController
  def index
     @cart_items = CartItem.where(customer:current_customer)
  end

  def create
    @cart_item = CartItem.new(cart_items_params)
    @cart_item.item_id =　Item.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.save!
    redirect_to public_cart_items_path
  end

  private
  def cart_items_params
    params.require(:cart_item).permit( :amount)
  end
end
