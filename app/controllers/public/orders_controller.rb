class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    
    @addresses = current_customer.address
  end
  
  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])
  end
  
  
  

  def index
    @orders = current_customer.orders
  end

  def show
  end
  
   private
   
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end
end
