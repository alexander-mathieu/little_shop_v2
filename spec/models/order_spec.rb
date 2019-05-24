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
      @order_item_10 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 10, price: 100.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 25, 01, 04, 44))
      @orders = Order.all
    end

    it '.top_three_order_item_quantity' do
      expect(@orders.top_three_order_item_quantity).to eq([@order_4, @order_1, @order_2])
    end
  end
end
