class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def total_item_count
    items.sum(:quantity)
  end

  def total_price
    order_items.sum(:price)
  end
end
