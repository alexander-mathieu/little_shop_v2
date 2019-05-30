require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it {should have_many(:items)}
    it {should have_many :orders}
  end

  describe "class methods" do
    before :each do
      @user_1 = create(:merchant, name: "merch1", city: "Denver", state: "CO")
      @user_2 = create(:user, name: "Adam")
      @user_3 = create(:merchant, name: "merch3", city: "Sacramento", state: "CA")
      @user_4 = create(:merchant, name: "merch4", city: "Colorado Springs", state: "CO")
      @user_5 = create(:user, name: "Carly")
      @user_6 = create(:merchant, name: "merch6", city: "Denver", state: "NY")
      @user_7 = create(:user, name: "Daniel")
      @user_8 = create(:user, city: "St. Louis", state: "MO", name: "Gerald")
      @user_9 = create(:user, city: "Kansas City", state: "KS", name: "Tommy")
      @user_10 = create(:user, city: "Kansas City", state: "MO", name: "Yolanda")
      @users = User.all

      @item_1 = create(:item, price: 10, user: @user_1)
      @item_2 = create(:item, price: 20, user: @user_1)
      @item_3 = create(:item, price: 30, user: @user_1)
      @item_4 = create(:item, price: 100, user: @user_4)
      @item_5 = create(:item, price: 200, user: @user_4)
      @item_6 = create(:item, price: 300, user: @user_4)
      @item_7 = create(:item, price: 1000, user: @user_3)
      @item_8 = create(:item, price: 2000, user: @user_3)
      @item_9 = create(:item, price: 3000, user: @user_3)
      @item_10 = create(:item, price: 1, user: @user_6)

      @order_1 = create(:shipped, user: @user_2)
      @order_2 = create(:shipped, user: @user_7, created_at: 5.days.ago, updated_at: 1.days.ago)
      @order_3 = create(:shipped, user: @user_8, created_at: 2.days.ago, updated_at: 1.days.ago)
      @order_4 = create(:shipped, user: @user_9, created_at: 3.days.ago, updated_at: 1.days.ago)
      @order_5 = create(:shipped, user: @user_9)
      @order_6 = create(:shipped, user: @user_9, created_at: 2.days.ago, updated_at: 1.days.ago)
      @order_7 = create(:shipped, user: @user_9)
      @order_8 = create(:shipped, user: @user_9)
      @order_9 = create(:shipped, user: @user_10)
      @order_10 = create(:shipped, user: @user_10)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 10.00, fulfilled: true, created_at: 5.days.ago, updated_at: 1.days.ago)
      @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 2, price: 20.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
      @order_item_3 = @order_1.order_items.create!(item_id: @item_3.id, quantity: 2, price: 30.00, fulfilled: false, created_at: 15.days.ago, updated_at: 1.days.ago)
      @order_item_4 = @order_2.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true, created_at: 7.days.ago, updated_at: 1.days.ago)
      @order_item_5 = @order_2.order_items.create!(item_id: @item_5.id, quantity: 2, price: 200.00, fulfilled: true, created_at: 3.days.ago, updated_at: 1.days.ago)
      @order_item_6 = @order_2.order_items.create!(item_id: @item_6.id, quantity: 6, price: 200.00, fulfilled: false, created_at: 20.days.ago, updated_at: 1.days.ago)
      @order_item_7 = @order_3.order_items.create!(item_id: @item_8.id, quantity: 2, price: 2000.00, fulfilled: true, created_at: 3.days.ago, updated_at: 1.days.ago)
      @order_item_8 = @order_3.order_items.create!(item_id: @item_9.id, quantity: 3, price: 3000.00, fulfilled: true, created_at: 1.days.ago, updated_at: 1.days.ago)
      @order_item_9 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 100, price: 1.00, fulfilled: true, created_at: 3.days.ago, updated_at: 1.days.ago)
    end

    it ".find_default_users" do
      expect(User.find_default_users).to eq([@user_2, @user_5, @user_7, @user_8, @user_9, @user_10])
    end

    it ".find_merchants" do
      expect(@users.find_merchants).to eq([@user_1, @user_3, @user_4, @user_6])
    end

    it ".top_three_revenue" do
      revenue = @users.top_three_revenue.map { |user| user.revenue }

      expect(@users.top_three_revenue).to eq([@user_3, @user_4, @user_1])
      expect(revenue).to eq([13000, 1700, 110])
    end

    it ".top_three_fulfillments_fastest_and_slowest" do
      high_avg_fulfillment_times = @users.top_three_fulfillments("asc").map { |user| user.average_fulfillment_time.split[0..1].join(' ') }
      low_avg_fulfillment_times = @users.top_three_fulfillments("desc").map { |user| user.average_fulfillment_time.split[0..1].join(' ') }

      expect(@users.top_three_fulfillments("asc")).to eq([@user_3, @user_6, @user_4])
      expect(@users.top_three_fulfillments("desc")).to eq([@user_1, @user_4, @user_6])
      expect(high_avg_fulfillment_times).to eq(["1 day", "2 days", "4 days"])
      expect(low_avg_fulfillment_times).to eq(["6 days", "4 days", "2 days"])
    end

    it ".top_three_orders_by_state" do
      order_item_10 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_8.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_15 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      states = @users.top_three_orders_by_state.map { |user| user.state }
      order_count_per_state = @users.top_three_orders_by_state.map { |user| user.state_order_count }

      expect(states).to eq ([@user_1.state, @user_6.state, @user_3.state])
      expect(states).to eq ([@user_4.state, @user_6.state, @user_3.state])
      expect(order_count_per_state).to eq ([5, 4, 1])
    end

    it '.top_three_orders_by_city_state' do
      order_item_10 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_8.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_15 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      city_states = @users.top_three_orders_by_city_state.map { |user| user.city_state }
      order_count_per_city_state = @users.top_three_orders_by_city_state.map { |user| user.city_state_order_count }

      expect(city_states).to eq (["Denver, NY", "Denver, CO", "Colorado Springs, CO"])
      expect(order_count_per_city_state).to eq ([4, 3, 2])
    end

    it '.top_three_states_shipped_to' do
      order_item_10 = @order_2.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_5.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_6.order_items.create!(item_id: @item_10.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      states = @users.top_three_states_shipped_to(@user_6).map { |user| user.state }
      order_count_per_state = @users.top_three_states_shipped_to(@user_6).map { |user| user.order_count }

      expect(states).to eq([@user_9.state, @user_10.state, @user_2.state])
      expect(order_count_per_state).to eq([3, 2, 1])
    end

    it '.top_three_cities_shipped_to' do
      order_item_10 = @order_2.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_5.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_6.order_items.create!(item_id: @item_10.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      cities = @users.top_three_cities_shipped_to(@user_6).map { |user| user.city_state }
      order_count_per_city = @users.top_three_cities_shipped_to(@user_6).map { |user| user.order_count }

      expect(cities).to eq(["Kansas City, KS", "Kansas City, MO", "Springfield, VA"])
      expect(order_count_per_city).to eq([3, 2, 1])
    end

    it '.top_orders_customer' do
      expect(@users.top_orders_customer(@user_1)).to eq([@user_2])
    end

    it '.top_items_customer' do
      expect(@users.top_items_customer(@user_1)).to eq([@user_2])
    end

    it '.top_three_money_customers' do
      order_item_10 = @order_8.order_items.create!(item_id: @item_1.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_10.order_items.create!(item_id: @item_1.id, quantity: 2, price: 50.00, fulfilled: true)

      customer_money_spent = @users.top_three_money_customers(@user_1).map { |customer| customer.money_total }

      expect(@users.top_three_money_customers(@user_1)).to eq([@user_2, @user_10, @user_9])
      expect(customer_money_spent).to eq([110, 100, 80])
    end
  end

  describe "instance methods" do
    before :each do
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state:"Merchant 1 State", zip: "12345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state:"Merchant 2 State", zip: "42345", password: "123456")
      @user_1= User.create!(email: "user_1@gmail.com", role: 0, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip:"52345", password: "123456")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 0, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip:"62345", password: "123456")
      @user_3 = User.create!(email: "user_3@gmail.com", role: 0, name: "User 3", address: "User 3 Address", city: "User 3 City", state: "User 3 State", zip:"72345", password: "123456")
      @user_4 = User.create!(email: "user_4@gmail.com", role: 0, name: "User 4", address: "User 4 Address", city: "User 4 City", state: "User 4 State", zip:"82345", password: "123456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 10)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 15)
      @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 20)
      @item_4 = @merchant_1.items.create!(name: "Item 4", active: true, price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 25)
      @item_5 = @merchant_1.items.create!(name: "Item 5", active: true, price: 5.00, description: "Item 5 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 30)
      @item_6 = @merchant_1.items.create!(name: "Item 6", active: true, price: 6.00, description: "Item 6 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 35)
      @item_7 = @merchant_2.items.create!(name: "Item 7", active: true, price: 7.00, description: "Item 7 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 40)
      @item_8 = @merchant_2.items.create!(name: "Item 8", active: true, price: 8.00, description: "Item 8 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 45)
      @item_9 = @merchant_2.items.create!(name: "Item 9", active: true, price: 9.00, description: "Item 9 Description", image: "https://tradersofafrica.com/img/no-productphoto.jpg", inventory: 50)
      @item_10 = @merchant_2.items.create!(name: "Item !0", active: true,  price: 10.00, description: "Item 10 Description", image: "https://tradersofafrica.com/img/noproduct-photo.jpg", inventory: 55)

      @order_1 = @user_1.orders.create!(status: 2)
      @order_2 = @user_1.orders.create!(status: 2)
      @order_3 = @user_2.orders.create!(status: 2)
      @order_4 = @user_2.orders.create!(status: 2)
      @order_5 = @user_3.orders.create!(status: 2)
      @order_6 = @user_3.orders.create!(status: 2)
      @order_7 = @user_4.orders.create!(status: 3)
      @order_8 = @user_4.orders.create!(status: 0)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_4 = @order_3.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_5 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_6 = @order_3.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
      @order_item_7 = @order_4.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_8 = @order_4.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_9 = @order_4.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
      @order_item_10 = @order_4.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
      @order_item_11 = @order_5.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_12 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_13 = @order_5.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
      @order_item_14 = @order_5.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
      @order_item_15 = @order_5.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
      @order_item_16 = @order_6.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_17 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_18 = @order_6.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
      @order_item_19 = @order_6.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
      @order_item_20 = @order_6.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
      @order_item_21 = @order_6.order_items.create!(item_id: @item_6.id, quantity: 6, price: 36.00, fulfilled: true)
      @order_item_22 = @order_7.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_23 = @order_7.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_24 = @order_7.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
      @order_item_25 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
      @order_item_26 = @order_7.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
      @order_item_27 = @order_7.order_items.create!(item_id: @item_6.id, quantity: 6, price: 36.00, fulfilled: true)
      @order_item_28 = @order_7.order_items.create!(item_id: @item_7.id, quantity: 7, price: 49.00, fulfilled: true)
      @order_item_29 = @order_8.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_30 = @order_8.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_31 = @order_8.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
      @order_item_32 = @order_8.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
      @order_item_33 = @order_8.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
      @order_item_34 = @order_8.order_items.create!(item_id: @item_6.id, quantity: 6, price: 36.00, fulfilled: true)
      @order_item_35 = @order_8.order_items.create!(item_id: @item_7.id, quantity: 7, price: 49.00, fulfilled: true)
      @order_item_36 = @order_8.order_items.create!(item_id: @item_8.id, quantity: 8, price: 64.00, fulfilled: true)
      @orders = Order.all
    end

    it "#top_five_sold" do
      expect(@merchant_1.top_five_sold).to eq([@item_3, @item_4, @item_2, @item_5, @item_1])

      expect(@merchant_1.top_five_sold[0].total_quantity).to eq(12)
      expect(@merchant_1.top_five_sold[1].total_quantity).to eq(12)
      expect(@merchant_1.top_five_sold[2].total_quantity).to eq(10)
      expect(@merchant_1.top_five_sold[3].total_quantity).to eq(10)
      expect(@merchant_1.top_five_sold[4].total_quantity).to eq(6)
    end

    it '#pending_orders' do
      order_9 = create(:pending, user: @user_2)
      order_10 = create(:pending, user: @user_2)
      order_item_37 = create(:order_item, item: @item_8, order: order_9)
      order_item_38 = create(:order_item, item: @item_9, order: order_9)
      order_item_39 = create(:order_item, item: @item_7, order: order_10)
      order_item_40 = create(:order_item, item: @item_10, order: order_10)
      order_item_41 = create(:order_item, item: @item_1, order: order_10)
      expect(@merchant_2.pending_orders).to eq([@order_8, order_9, order_10])

    end

    it '#total_quantity_items_sold' do
      order_9 = create(:pending, user: @user_2)
      order_item_37 = create(:order_item, item: @item_8, order: order_9, quantity: 100, fulfilled: false)

      expect(@merchant_2.total_quantity_items_sold).to eq(22)
    end

    it '#total_items_in_inventory' do
      expect(@merchant_2.total_items_in_inventory).to eq(190)
    end

    it '#total_percentage_inventory_sold' do
      order_9 = create(:pending, user: @user_2)
      order_item_37 = create(:order_item, item: @item_8, order: order_9, quantity: 16, fulfilled: true)

      expect(@merchant_2.total_percentage_inventory_sold).to eq(20)
    end

    it "#deactivate_all_items" do
      @merchant_1.deactivate_all_items

      expect(@item_1.active).to eq(false)
      expect(@item_2.active).to eq(false)
      expect(@item_3.active).to eq(false)
      expect(@item_4.active).to eq(false)
      expect(@item_5.active).to eq(false)
      expect(@item_6.active).to eq(false)
    end

    it "#downgrade_to_user" do
      @merchant_1.downgrade_to_user

      expect(@merchant_1.role).to eq("default")
    end

    it "#upgrade_to_merchant" do
      @user_2.upgrade_to_merchant

      expect(@user_2.role).to eq("merchant")
    end
  end
end
