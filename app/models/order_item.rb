class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def subtotal_order_item
    price * amount
  end
end
