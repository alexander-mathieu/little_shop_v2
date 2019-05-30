require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should belong_to :user}
  it {should have_many :order_items}
  it {should have_many(:items).through(:order_items)}

  describe "class methods" do
    before :each do
      @user_1 = create(:merchant, city: "Denver", state: "CO")
      @user_2 = create(:user)
      @user_3 = create(:merchant, city: "Sacramento", state: "CA")
      @user_4 = create(:merchant, city: "Springfield", state: "CO")
      @user_5 = create(:user)
      @user_6 = create(:merchant, city: "Springfield", state: "NY")
      @user_7 = create(:user)
      @user_8 = create(:user)
      @user_9 = create(:user)
      @user_10 = create(:user)

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

      @order_1 = create(:packaged, user: @user_2, status: 0)
      @order_2 = create(:packaged, user: @user_7, status: 0)
      @order_3 = create(:packaged, user: @user_8, status: 0)
      @order_4 = create(:packaged, user: @user_9, status: 1)
      @order_5 = create(:packaged, user: @user_9, status: 1)
      @order_6 = create(:packaged, user: @user_9, status: 1)
      @order_7 = create(:packaged, user: @user_9, status: 2)
      @order_8 = create(:packaged, user: @user_9, status: 2)
      @order_9 = create(:packaged, user: @user_10, status: 2)
      @order_10 = create(:packaged, user: @user_10, status: 3)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 10.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 27, 01, 04, 44))
      @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      @order_item_3 = @order_1.order_items.create!(item_id: @item_3.id, quantity: 2, price: 60.00, fulfilled: true)
      @order_item_4 = @order_2.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      @order_item_5 = @order_2.order_items.create!(item_id: @item_5.id, quantity: 2, price: 400.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 12, 01, 01, 04, 44))
      @order_item_6 = @order_2.order_items.create!(item_id: @item_6.id, quantity: 4, price: 1200.00, fulfilled: true)
      @order_item_7 = @order_3.order_items.create!(item_id: @item_8.id, quantity: 2, price: 4000.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 29, 01, 04, 44))
      @order_item_8 = @order_3.order_items.create!(item_id: @item_9.id, quantity: 3, price: 9000.00, fulfilled: true)
      @order_item_9 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 25, 01, 04, 44))
      @order_item_10 = @order_3.order_items.create!(item_id: @item_1.id, quantity: 10, price: 100.00, fulfilled: true)
      @orders = Order.all
    end

    it '.top_three_order_item_quantity' do
      expect(@orders.top_three_order_item_quantity).to eq([@order_4, @order_3, @order_2])
    end

    it '.admin_dashboard_sort' do
      expect(@orders.admin_dashboard_sort).to eq([@order_4, @order_5, @order_6, @order_1, @order_2, @order_3, @order_7, @order_8, @order_9, @order_10])
    end
  end

  describe "instance methods" do
    before :each do
      @user_1 = User.create!(email: "user_1@gmail.com", role: 2, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "12345", password: "123456")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 2, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "22345", password: "123456")

      @user_8 = User.create!(email: "user_8@gmail.com", role: 0, name: "User 8", address: "User 8 Address", city: "User 8 City", state: "User 8 State", zip: "82345", password: "123456")

      @item_1 = @user_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @user_2.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @user_2.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)

      @order_1 = @user_8.orders.create!(status: 3)
      @order_2 = @user_8.orders.create!(status: 2)
      @order_3 = @user_8.orders.create!(status: 0)
      @order_4 = @user_8.orders.create!(status: 1)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_4 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_5 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_6 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: false)
      @order_item_7 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    end

    it "#ship" do
      @order_4.ship

      expect(@order_4.status).to eq("shipped")
    end

    it "#user_name" do
      expect(@order_1.user_name).to eq(@user_8.name)
    end

    it "#user_id" do
      expect(@order_1.user_id).to eq(@user_8.id)
    end

    it "#total_item_count" do
      expect(@order_1.total_item_count).to eq(2)
      expect(@order_2.total_item_count).to eq(5)
    end

    it "#total_price" do
      expect(@order_1.total_price).to eq(2.00)
      expect(@order_2.total_price).to eq(9.00)
    end

    it "#cancel_items" do
      @order_1.cancel_items

      expect(@order_item_4.fulfilled).to eq(false)
      expect(@order_item_1.fulfilled).to eq(false)

      @item_1.reload

      expect(@item_1.inventory).to eq(12)
    end
    it "#items_of_merchant" do
      expect(@order_1.items_of_merchant(@user_1.id)).to eq([@item_1, @item_1])
      expect(@order_2.items_of_merchant(@user_2.id)).to eq([@item_2, @item_2])
    end
    it "all_fulfilled?" do
      expect(@order_1.all_fulfilled?).to eq(true)
      expect(@order_3.all_fulfilled?).to eq(false)
    end
    
  end
end
