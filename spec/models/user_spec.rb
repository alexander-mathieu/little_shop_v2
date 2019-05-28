require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it {should have_many(:items)}
    it {should have_many :orders}
  end

  describe "class methods" do
    before :each do
      @user_1 = create(:merchant, city: "Denver", state: "CO")
      @user_2 = create(:user)
      @user_3 = create(:merchant, city: "Sacramento", state: "CA")
      @user_4 = create(:merchant, city: "Springfield", state: "CO")
      @user_5 = create(:user)
      @user_6 = create(:merchant, city: "Springfield", state: "NY")
      @user_7 = create(:user)
      @user_8 = create(:user, city: "Cheyenne", state: "WY")
      @user_9 = create(:user, city: "Billings", state: "MT")
      @user_10 = create(:user, city: "Boise", state: "ID")
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

      @order_1 = create(:packaged, user: @user_2)
      @order_2 = create(:packaged, user: @user_7)
      @order_3 = create(:packaged, user: @user_8)
      @order_4 = create(:packaged, user: @user_9)
      @order_5 = create(:packaged, user: @user_9)
      @order_6 = create(:packaged, user: @user_9)
      @order_7 = create(:packaged, user: @user_9)
      @order_8 = create(:packaged, user: @user_9)
      @order_9 = create(:packaged, user: @user_10)
      @order_10 = create(:packaged, user: @user_10)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 10.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 27, 01, 04, 44))
      @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      @order_item_3 = @order_1.order_items.create!(item_id: @item_3.id, quantity: 2, price: 60.00, fulfilled: true)
      @order_item_4 = @order_2.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      @order_item_5 = @order_2.order_items.create!(item_id: @item_5.id, quantity: 2, price: 400.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 12, 01, 01, 04, 44))
      @order_item_6 = @order_2.order_items.create!(item_id: @item_6.id, quantity: 4, price: 1200.00, fulfilled: true)
      @order_item_7 = @order_3.order_items.create!(item_id: @item_8.id, quantity: 2, price: 4000.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 29, 01, 04, 44))
      @order_item_8 = @order_3.order_items.create!(item_id: @item_9.id, quantity: 3, price: 9000.00, fulfilled: true)
      @order_item_9 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 25, 01, 04, 44))
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
      expect(@users.top_three_fulfillments("asc")).to eq([@user_6, @user_1, @user_3])
      expect(@users.top_three_fulfillments("desc")).to eq([@user_4, @user_3, @user_1])
    end

    it ".top_three_orders_by_state_or_city" do
      order_item_10 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_8.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_15 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      states = @users.top_three_orders_by("state").map { |user| user.state }
      order_count_per_state = @users.top_three_orders_by("state").map { |user| user.state_order_count }

      cities = @users.top_three_orders_by("city").map { |user| user.city }
      order_count_per_city = @users.top_three_orders_by("city").map { |user| user.city_order_count }

      expect(states).to eq ([@user_1.state, @user_6.state, @user_3.state])
      expect(states).to eq ([@user_4.state, @user_6.state, @user_3.state])
      expect(order_count_per_state).to eq ([5, 4, 1])
      expect(cities).to eq ([@user_4.city, @user_1.city, @user_3.city])
      expect(cities).to eq ([@user_6.city, @user_1.city, @user_3.city])
      expect(order_count_per_city).to eq ([6, 3, 1])
    end

    it '.top_three_states_shipped_to' do
      order_item_10 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_3.order_items.create!(item_id: @item_10.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      states = @users.top_three_states_shipped_to(@user_6).map { |user| user.state }
      order_count_per_state = @users.top_three_states_shipped_to(@user_6).map { |user| user.order_count }

      expect(states).to eq([@user_9.state, @user_10.state, @user_8.state])
      expect(order_count_per_state).to eq([3, 2, 1])
    end

    it '.top_three_cities_shipped_to' do
      order_item_10 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_3.order_items.create!(item_id: @item_10.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      cities = @users.top_three_cities_shipped_to(@user_6).map { |user| user.city_state }
      order_count_per_city = @users.top_three_cities_shipped_to(@user_6).map { |user| user.order_count }

      expect(cities).to eq(["Billings, MT", "Boise, ID", "Cheyenne, WY"])
      expect(order_count_per_city).to eq([3, 2, 1])
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

  end
end
