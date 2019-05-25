class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def self.top_three_order_item_quantity
    joins(:order_items)
          .select('orders.*', 'SUM(order_items.quantity) AS order_item_quantity')
          .group('orders.id')
          .order('order_item_quantity desc')
          .limit(3)
<<<<<<< HEAD
        end

=======
  end
    
>>>>>>> 66fe9b12e4d4658ca92be887ca1c5d842b50d30b
  def total_item_count
    items.sum(:quantity)
  end

  def total_price
    order_items.sum(:price)

  end
end
