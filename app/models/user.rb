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
  validates :password_digest, presence: true

  def self.find_default_users
    where(role: "default").order(name: :asc)
  end

  def self.find_merchants
    where(role: "merchant")
  end

  def self.top_three_revenue
    find_merchants.joins(items: :order_items)
                  .select('users.*', 'SUM(order_items.price) AS revenue')
                  .group('users.id')
                  .order('revenue desc')
                  .limit(3)
  end

  def self.top_three_fulfillments(speed)
    find_merchants.joins(items: :order_items)
                  .select('users.*', 'SUM(order_items.updated_at - order_items.created_at) AS fulfillment_time')
                  .where('order_items.fulfilled = true')
                  .group('users.id')
                  .order("fulfillment_time #{speed}")
                  .limit(3)
  end

  def self.top_three_orders_by(city_or_state)
    find_merchants.joins(items: :order_items)
                  .select("users.#{city_or_state}", "COUNT(DISTINCT(order_items.order_id)) AS #{city_or_state}_order_count")
                  .group("users.#{city_or_state}").distinct
                  .order("#{city_or_state}_order_count desc")
                  .limit(3)
  end

  def pending_orders
    Order.joins(items: :order_items).select('orders.*', 'items.user_id')
    .where('items.user_id' => self.id, 'orders.status' => 0)
    .distinct
  end

  def top_five_sold
    items.select('items.*, SUM(order_items.quantity) AS total_quantity')
    .joins(:orders)
    .where(active: true, orders: {status: 2})
    .group(:id)
    .order('total_quantity DESC, items.name')
    .limit(5)
  end

  # - total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory (eg, if I have sold 1,000 things and still have 9,000 things in inventory, the message would say something like "Sold 1,000 items, which is 10% of your total inventory")
  # def total_quantity_items_sold
  #   # items.sum('order_items.quantity')
  # end
  # - top 3 states where my items were shipped, and their quantities
  # - top 3 city/state where my items were shipped, and their quantities (Springfield, MI should not be grouped with Springfield, CO)
  # - name of the user with the most orders from me (pick one if there's a tie), and number of orders
  # - name of the user who bought the most total items from me (pick one if there's a tie), and the total quantity
  # - top 3 users who have spent the most money on my items, and the total amount they've spent
end
