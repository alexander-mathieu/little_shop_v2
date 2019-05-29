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

  def self.top_three_states_shipped_to(merchant)
    joins(orders: :order_items)
    .select('users.state', 'COUNT(order_items.order_id) AS order_count')
    .where(role: 0, 'order_items.item_id' => merchant.items.ids, 'order_items.fulfilled' => true)
    .group('users.state').distinct
    .order('order_count desc')
    .limit(3)
  end

  def self.top_three_cities_shipped_to(merchant)
    joins(orders: :order_items)
    .select("CONCAT(users.city, ', ', users.state) AS city_state", 'COUNT(order_items.order_id) AS order_count')
    .where(role: 0, 'order_items.item_id' => merchant.items.ids, 'order_items.fulfilled' => true)
    .group('city_state').distinct
    .order('order_count desc')
    .limit(3)
  end

  def self.top_orders_customer(merchant)
    joins(orders: :order_items)
    .select('users.*', 'COUNT(DISTINCT(order_items.order_id)) AS order_count')
    .where(role: 0, 'order_items.item_id' => merchant.items.ids)
    .group('users.id')
    .order('order_count desc')
    .limit(1)
  end

  def self.top_items_customer(merchant)
    joins(orders: :order_items)
    .select('users.*', 'COUNT(order_items.id) AS item_count')
    .where(role: 0, 'order_items.item_id' => merchant.items.ids)
    .group('users.id')
    .order('item_count desc')
    .limit(1)
  end

  # - top 3 users who have spent the most money on my items, and the total amount they've spent
  def self.top_three_money_customers(merchant)
    joins(orders: :order_items)
    .select('users.*', 'SUM(order_items.price) AS money_total')
    .where(role: 0, 'order_items.item_id' => merchant.items.ids)
    .group('users.id')
    .order('money_total desc')
    .limit(3)
  end

  def pending_orders
    Order.joins(items: :order_items).select('orders.*', 'items.user_id')
    .where('items.user_id' => self.id, 'orders.status' => 0)
    .distinct.order(:id)
  end

  def top_five_sold
    items.select('items.*, SUM(order_items.quantity) AS total_quantity')
    .joins(:orders)
    .where(active: true, orders: {status: 2})
    .group(:id)
    .order('total_quantity DESC, items.name')
    .limit(5)
  end

  def total_quantity_items_sold
    items.joins(:order_items).select("order_items.*")
    .where("order_items.fulfilled": true)
    .sum("order_items.quantity")
  end

  def total_items_in_inventory
    items.sum(:inventory)
  end

  def total_percentage_inventory_sold
    (total_quantity_items_sold / total_items_in_inventory.to_f) * 100
  end

  def deactivate_all_items
    items.update(active: false)
  end

  def downgrade_to_user
    update(role: 0)
  end

  def upgrade_to_merchant
    update(role: 1)
  end

  # - name of the user who bought the most total items from me (pick one if there's a tie), and the total quantity

  # - top 3 users who have spent the most money on my items, and the total amount they've spent
end
