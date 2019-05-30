require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @user_1 = create(:merchant, name: "kathy", city: "Denver", state: "CO")
    @user_2 = create(:user)
    @user_3 = create(:merchant, name: "tommy", city: "Sacramento", state: "CA")
    @user_4 = create(:merchant, name: "jill", city: "Colorado Springs", state: "CO")
    @user_5 = create(:user)
    @user_6 = create(:merchant, name: "sharon", city: "New York", state: "NY")
    @user_7 = create(:user)
    @user_8 = create(:user)
    @user_9 = create(:user)
    @user_10 = create(:user)

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

    @order_1 = create(:shipped, user: @user_2, created_at: 3.days.ago, updated_at: 1.days.ago)
    @order_2 = create(:shipped, user: @user_7, created_at: 10.days.ago, updated_at: 1.days.ago)
    @order_3 = create(:shipped, user: @user_8, created_at: 6.days.ago, updated_at: 1.days.ago)
    @order_4 = create(:shipped, user: @user_9, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_5 = create(:shipped, user: @user_9, created_at: 3.days.ago, updated_at: 1.days.ago)
    @order_6 = create(:shipped, user: @user_9, created_at: 5.days.ago, updated_at: 1.days.ago)
    @order_7 = create(:shipped, user: @user_9, created_at: 7.days.ago, updated_at: 1.days.ago)
    @order_8 = create(:shipped, user: @user_9, created_at: 2.days.ago, updated_at: 1.days.ago)
    @order_9 = create(:shipped, user: @user_10, created_at: 2.days.ago, updated_at: 1.days.ago)
    @order_10 = create(:shipped, user: @user_10, created_at: 5.days.ago, updated_at: 1.days.ago)

    @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 10.00, fulfilled: true, created_at: 1.days.ago, updated_at: 1.days.ago)
    @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true, created_at: 3.days.ago, updated_at: 1.days.ago)
    @order_item_3 = @order_1.order_items.create!(item_id: @item_3.id, quantity: 2, price: 60.00, fulfilled: false, created_at: 25.days.ago, updated_at: 1.days.ago)
    @order_item_4 = @order_2.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true, created_at: 8.days.ago, updated_at: 1.days.ago)
    @order_item_5 = @order_2.order_items.create!(item_id: @item_5.id, quantity: 2, price: 400.00, fulfilled: true, created_at: 6.days.ago, updated_at: 1.days.ago)
    @order_item_6 = @order_2.order_items.create!(item_id: @item_6.id, quantity: 4, price: 1200.00, fulfilled: false, created_at: 25.days.ago, updated_at: 1.days.ago)
    @order_item_7 = @order_3.order_items.create!(item_id: @item_8.id, quantity: 2, price: 4000.00, fulfilled: true, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_item_8 = @order_3.order_items.create!(item_id: @item_9.id, quantity: 3, price: 9000.00, fulfilled: true, created_at: 2.days.ago, updated_at: 1.days.ago)
    @order_item_9 = @order_4.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true, created_at: 5.days.ago, updated_at: 1.days.ago)
  end


  describe "when I visit the merchant's index page" do
    it 'I see all merchants names with city, state, and date they registered' do
      visit merchants_path

      within "#merchant-#{@user_1.id}" do
        expect(page).to have_content(@user_1.name)
        expect(page).to have_link(@user_1.name)
        expect(page).to have_content(@user_1.city)
        expect(page).to have_content(@user_1.state)
        expect(page).to have_content(@user_1.created_at.to_formatted_s(:long).slice(0...-6))
      end

      within "#merchant-#{@user_3.id}" do
        expect(page).to have_content(@user_3.name)
        expect(page).to have_link(@user_3.name)
        expect(page).to have_content(@user_3.city)
        expect(page).to have_content(@user_3.state)
        expect(page).to have_content(@user_3.created_at.to_formatted_s(:long).slice(0...-6))
      end

      within "#merchant-#{@user_4.id}" do
        expect(page).to have_content(@user_4.name)
        expect(page).to have_link(@user_4.name)
        expect(page).to have_content(@user_4.city)
        expect(page).to have_content(@user_4.state)
        expect(page).to have_content(@user_4.created_at.to_formatted_s(:long).slice(0...-6))
      end
    end

    it 'I see stats with the top 3 highest revenue merchants' do
      visit merchants_path

      revenue = @users.top_three_revenue.map { |user| user.revenue }

      within "#merchant-stats" do
        within "#top-3-revenue" do
          expect(@user_3.name).to appear_before(@user_6.name)
          expect(@user_6.name).to appear_before(@user_4.name)
          expect(page).to have_content(revenue[0])
          expect(page).to have_content(revenue[1])
          expect(page).to have_content(revenue[2])
        end
      end
    end

    it 'I see stats with the top 3 fastest fulfillment merchants' do
      visit merchants_path

      fulfillment_time = @users.top_three_fulfillments("asc").map { |user| user.average_fulfillment_time.split[0..1].join(' ') }

      within "#merchant-stats" do
        within "#top-3-fulfillments" do
          expect(@user_1.name).to appear_before(@user_3.name)
          expect(@user_3.name).to appear_before(@user_6.name)
          expect(fulfillment_time[0]).to appear_before(fulfillment_time[1])
          expect(fulfillment_time[1]).to appear_before(fulfillment_time[2])
        end
      end
    end

    it 'I see stats with the top 3 slowest fulfillment merchants' do
      visit merchants_path

      fulfillment_time = @users.top_three_fulfillments("desc").map { |user| user.average_fulfillment_time.split[0..1].join(' ') }

      within "#merchant-stats" do
        within "#bottom-3-fulfillments" do
          expect(@user_4.name).to appear_before(@user_6.name)
          expect(@user_6.name).to appear_before(@user_3.name)
          expect(fulfillment_time[0]).to appear_before(fulfillment_time[1])
          expect(fulfillment_time[1]).to appear_before(fulfillment_time[2])
        end
      end
    end

    it 'I see stats with the top 3 states with the most orders' do
      order_item_10 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_8.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_15 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      visit merchants_path

      within "#merchant-stats" do
        within "#top-3-states" do
          expect(@user_4.state).to appear_before(@user_6.state)
          expect(@user_6.state).to appear_before(@user_3.state)
        end
      end
    end

    it 'I see stats with the top 3 cities with the most orders' do
      order_item_10 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_11 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 40.00, fulfilled: true)
      order_item_12 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 1, price: 100.00, fulfilled: true)
      order_item_13 = @order_8.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_14 = @order_9.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)
      order_item_15 = @order_10.order_items.create!(item_id: @item_10.id, quantity: 100, price: 100.00, fulfilled: true)

      visit merchants_path

      within "#merchant-stats" do
        within "#top-3-cities" do
          expect("#{@user_6.city}, #{@user_6.state}").to appear_before("#{@user_1.city}, #{@user_1.state}")
          expect("#{@user_1.city}, #{@user_1.state}").to appear_before("#{@user_4.city}, #{@user_4.state}")
          expect("4 orders").to appear_before("3 orders")
          expect("3 orders").to appear_before("2 orders")
        end
      end
    end

    it 'I see stats with the top 3 cities with the most orders' do
      order_item_10 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 10, price: 100.00, fulfilled: true, created_at: Time.zone.local(2018, 11, 24, 01, 04, 44), updated_at: Time.zone.local(2018, 11, 25, 01, 04, 44))
      visit merchants_path

      within "#merchant-stats" do
        within "#top-3-orders" do
          expect(@order_4.id.to_s).to appear_before(@order_1.id.to_s)
          expect(@order_1.id.to_s).to appear_before(@order_2.id.to_s)
        end
      end
    end

    describe "as an admin" do
      it "show me names as links to merchant_path(merchant)" do
        @admin_1 = create(:admin)
        visit root_path

        click_on "Login"
        fill_in "email", with: @admin_1.email
        fill_in "password", with: @admin_1.password
        click_on "Log In"
        visit merchants_path

        within "#merchant-#{@user_1.id}" do
          expect(page).to have_link(@user_1.name)
          expect(page).to have_content(@user_1.city)
          expect(page).to have_content(@user_1.state)
        end
        within "#merchant-#{@user_4.id}" do
          expect(page).to have_link(@user_4.name)
          expect(page).to have_content(@user_4.city)
          expect(page).to have_content(@user_4.state)
        end

        click_link @user_1.name
        expect(current_path).to eq(merchant_path(@user_1))
        visit merchants_path
        click_link @user_4.name
        expect(current_path).to eq(merchant_path(@user_4))
      end
    end
  end

end
