require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @user_1 = User.create!(email: "user_1@gmail.com", role: 2, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State",zip:"12345", password: "123456")
    @user_2 = User.create!(email: "user_2@gmail.com", role: 2, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State",zip:"22345", password: "123456")
    @user_3 = User.create!(email: "user_3@gmail.com", role: 2, name: "User 3", address: "User 3 Address", city: "User 3 City", state: "User 3 State",zip:"32345", password: "123456")
    @user_4 = User.create!(email: "user_4@gmail.com", role: 2, name: "User 4", address: "User 4 Address", city: "User 4 City", state: "User 4 State",zip:"42345", password: "123456")
    @user_5 = User.create!(email: "user_5@gmail.com", role: 0, name: "User 5", address: "User 5 Address", city: "User 5 City", state: "User 5 State",zip:"52345", password: "123456")
    @user_6 = User.create!(email: "user_6@gmail.com", role: 0, name: "User 6", address: "User 6 Address", city: "User 6 City", state: "User 6 State",zip:"62345", password: "123456")
    @user_7 = User.create!(email: "user_7@gmail.com", role: 0, name: "User 7", address: "User 7 Address", city: "User 7 City", state: "User 7 State",zip:"72345", password: "123456")
    @user_8 = User.create!(email: "user_8@gmail.com", role: 0, name: "User 8", address: "User 8 Address", city: "User 8 City", state: "User 8 State",zip:"82345", password: "123456")

    @item_1 = @user_1.items.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 10)
    @item_2 = @user_2.items.create!(name: "Item 2", price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 15)
    @item_3 = @user_2.items.create!(name: "Item 3", price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 20)
    @item_4 = @user_3.items.create!(name: "Item 4", price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 25)
    @item_5 = @user_3.items.create!(name: "Item 5", price: 5.00, description: "Item 5 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 30)
    @item_6 = @user_3.items.create!(name: "Item 6", price: 6.00, description: "Item 6 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 35)
    @item_7 = @user_4.items.create!(name: "Item 7", price: 7.00, description: "Item 7 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 40)
    @item_8 = @user_4.items.create!(name: "Item 8", price: 8.00, description: "Item 8 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 45)
    @item_9 = @user_4.items.create!(name: "Item 9", price: 9.00, description: "Item 9 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 50)
    @item_10 = @user_4.items.create!(name: "Item 10", price: 10.00, description: "Item 10 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 55)

    @order_1 = @user_5.orders.create!(status: 3)
    @order_2 = @user_5.orders.create!(status: 3)
    @order_3 = @user_6.orders.create!(status: 3)
    @order_4 = @user_6.orders.create!(status: 3)
    @order_5 = @user_7.orders.create!(status: 3)
    @order_6 = @user_7.orders.create!(status: 3)
    @order_7 = @user_8.orders.create!(status: 3)
    @order_8 = @user_8.orders.create!(status: 3)

    @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_2 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_3 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_4 = @order_3.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_5 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_6 = @order_3.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
    @order_item_7 = @order_4.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_8 = @order_4.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_9 = @order_4.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
    @order_item_10 = @order_4.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
    @order_item_11 = @order_5.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_12 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_13 = @order_5.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
    @order_item_14 = @order_5.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
    @order_item_15 = @order_5.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
    @order_item_16 = @order_6.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_17 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_18 = @order_6.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
    @order_item_19 = @order_6.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
    @order_item_20 = @order_6.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
    @order_item_21 = @order_6.order_items.create!(item_id: @item_6.id, quantity: 6, price: 36.00, fulfilled: true)
    @order_item_22 = @order_7.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_23 = @order_7.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_24 = @order_7.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
    @order_item_25 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
    @order_item_26 = @order_7.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
    @order_item_27 = @order_7.order_items.create!(item_id: @item_6.id, quantity: 6, price: 36.00, fulfilled: true)
    @order_item_28 = @order_7.order_items.create!(item_id: @item_7.id, quantity: 7, price: 49.00, fulfilled: true)
    @order_item_29 = @order_8.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
    @order_item_30 = @order_8.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_31 = @order_8.order_items.create!(item_id: @item_3.id, quantity: 3, price: 9.00, fulfilled: true)
    @order_item_32 = @order_8.order_items.create!(item_id: @item_4.id, quantity: 4, price: 16.00, fulfilled: true)
    @order_item_33 = @order_8.order_items.create!(item_id: @item_5.id, quantity: 5, price: 25.00, fulfilled: true)
    @order_item_34 = @order_8.order_items.create!(item_id: @item_6.id, quantity: 6, price: 36.00, fulfilled: true)
    @order_item_35 = @order_8.order_items.create!(item_id: @item_7.id, quantity: 7, price: 49.00, fulfilled: true)
    @order_item_36 = @order_8.order_items.create!(item_id: @item_8.id, quantity: 8, price: 64.00, fulfilled: true)
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
  end

  describe "class methods" do
    it ".most_popular" do
      expect(Item.most_popular). to eq([@item_4, @item_5, @item_3, @item_6, @item_2])
    end

    it ".least_popular" do
      expect(Item.least_popular). to eq([@item_10, @item_9, @item_1, @item_8, @item_2])
    end
  end

  describe "instance methods" do
    it "#average_fulfillment_time" do
      expect(@item_1.average_fulfillment_time).to eq(8.0)
    end
  end
end
