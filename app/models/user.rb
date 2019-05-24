class User < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :orders

  enum role: ["default", "merchant", "admin"]

  validates :name, presence: true, length: (2..51)
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, length: (5..5)
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: (6..51)

  def self.find_merchants
    where(role: "merchant")
  end

  def self.top_three_revenue
    # select('books.*, avg(reviews.rating)').joins(:reviews).group('id').order('avg(reviews.rating) DESC').limit(3)
    find_merchants.select('users.*')
                  .joins(items: :order_items)
                  .select('users.*', 'sum(order_items.price) AS revenue')
                  .group('users.id')
                  .order('revenue desc')
                  .limit(3)
  end

  def self.top_three_fulfillments
    find_merchants.select('users.*')
                  .joins(items: :order_items)
                  .select('users.*', 'sum(order_items.updated_at - order_items.created_at) AS fulfillment_time')
                  .where('order_items.fulfilled = true')
                  .group('users.id')
                  .order('fulfillment_time asc')
                  .limit(3)
  end

  def top_five_sold
    items.select('items.*, SUM(order_items.quantity) AS total_quantity')
    .joins(:orders)
    .where(active: true, orders: {status: 2})
    .group(:id)
    .order('total_quantity DESC, items.name')
    .limit(5)
  end
end
