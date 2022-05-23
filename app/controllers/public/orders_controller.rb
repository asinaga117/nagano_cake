class Public::OrdersController < ApplicationController
  def new
    @order = Order.new

    @addresses = current_customer.address
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
      if @order.save!
        @cart_items = current_customer.cart_items
        @cart_items.each do |cart|
          order_item = OrderItem.new
          order_item.item_id = cart.item_id
          order_item.price = (cart.item.price * 1.1).floor
          order_item.amount = cart.amount
          order_item.order_id = @order.id
          order_item.save
        end
        redirect_to public_orders_complete_path
      else
        @order = Order.new(order_params)
      end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

   private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :status)
  end
end
