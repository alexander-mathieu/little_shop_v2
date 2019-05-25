class Item < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :orders, through: :order_items

  def average_fulfillment_time
    order_items.average('updated_at - created_at')
  end

  def find_order_item(order_id)
    order_items.find_by(item_id: id, order_id: order_id) 
  end

  def self.most_popular
    select('items.*, SUM(order_items.quantity) AS total_quantity')
    .joins(:order_items)
    .where(active: true, order_items: {fulfilled: true})
    .order('total_quantity DESC, items.name')
    .group(:id)
    .limit(5)
  end

  def self.least_popular
    select('items.*, COALESCE(SUM(order_items.quantity), 0) AS total_quantity')
    .left_joins(:orders)
    .where(active: true)
    .order('total_quantity, items.name')
    .group(:id)
    .limit(5)
  end
end
