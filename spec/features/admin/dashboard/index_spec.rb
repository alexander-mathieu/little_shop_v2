require 'rails_helper'

RSpec.describe "as an admin" do
  describe "when I visit /dashboard" do
    before :each do
      @admin = User.create!(email: "admin@gmail.com", role: 2, name: "Admin", address: "Admin Address", city: "Admin City", state: "Admin State", zip: "12345", password: "123456")
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state: "Merchant 1 State", zip: "12345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state: "Merchant 2 State", zip: "22345", password: "123456")
      @merchant_3 = User.create!(email: "merchant_3@gmail.com", role: 1, name: "Merchant 3", address: "Merchant 3 Address", city: "Merchant 3 City", state: "Merchant 3 State", zip: "32345", password: "123456")
      @merchant_4 = User.create!(email: "merchant_4@gmail.com", role: 1, name: "Merchant 4", address: "Merchant 4 Address", city: "Merchant 4 City", state: "Merchant 4 State", zip: "42345", password: "123456")
      @user_1= User.create!(email: "user_1@gmail.com", role: 0, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "52345", password: "123456")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 0, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "62345", password: "123456")
      @user_3 = User.create!(email: "user_3@gmail.com", role: 0, name: "User 3", address: "User 3 Address", city: "User 3 City", state: "User 3 State", zip: "72345", password: "123456")
      @user_4 = User.create!(email: "user_4@gmail.com", role: 0, name: "User 4", address: "User 4 Address", city: "User 4 City", state: "User 4 State", zip: "82345", password: "123456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @merchant_2.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)
      @item_4 = @merchant_2.items.create!(name: "Item 4", active: true, price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 25)
      @item_5 = @merchant_3.items.create!(name: "Item 5", active: true, price: 5.00, description: "Item 5 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 30)
      @item_6 = @merchant_3.items.create!(name: "Item 6", active: true, price: 6.00, description: "Item 6 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 35)
      @item_7 = @merchant_4.items.create!(name: "Item 7", active: true, price: 7.00, description: "Item 7 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 40)
      @item_8 = @merchant_4.items.create!(name: "Item 8", active: true, price: 8.00, description: "Item 8 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 45)
      @item_9 = @merchant_4.items.create!(name: "Item 9", active: true, price: 9.00, description: "Item 9 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 50)
      @item_10 = @merchant_4.items.create!(name: "Item !0", active: true, price: 10.00, description: "Item 10 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 55)

      @order_1 = @user_1.orders.create!(status: 0)
      @order_2 = @user_1.orders.create!(status: 0)
      @order_3 = @user_2.orders.create!(status: 1)
      @order_4 = @user_2.orders.create!(status: 1)
      @order_5 = @user_3.orders.create!(status: 2)
      @order_6 = @user_3.orders.create!(status: 2)
      @order_7 = @user_4.orders.create!(status: 3)
      @order_8 = @user_4.orders.create!(status: 3)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_4 = @order_3.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_5 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_6 = @order_3.order_items.create!(item_id: @item_3.id, quantity: 3, price: 3.00, fulfilled: true)
      @order_item_7 = @order_4.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_8 = @order_4.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_9 = @order_4.order_items.create!(item_id: @item_3.id, quantity: 3, price: 3.00, fulfilled: true)
      @order_item_10 = @order_4.order_items.create!(item_id: @item_4.id, quantity: 4, price: 4.00, fulfilled: true)
      @order_item_11 = @order_5.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_12 = @order_5.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_13 = @order_5.order_items.create!(item_id: @item_3.id, quantity: 3, price: 3.00, fulfilled: true)
      @order_item_14 = @order_5.order_items.create!(item_id: @item_4.id, quantity: 4, price: 4.00, fulfilled: true)
      @order_item_15 = @order_5.order_items.create!(item_id: @item_5.id, quantity: 5, price: 5.00, fulfilled: true)
      @order_item_16 = @order_6.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_17 = @order_6.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_18 = @order_6.order_items.create!(item_id: @item_3.id, quantity: 3, price: 3.00, fulfilled: true)
      @order_item_19 = @order_6.order_items.create!(item_id: @item_4.id, quantity: 4, price: 4.00, fulfilled: true)
      @order_item_20 = @order_6.order_items.create!(item_id: @item_5.id, quantity: 5, price: 5.00, fulfilled: true)
      @order_item_21 = @order_6.order_items.create!(item_id: @item_6.id, quantity: 6, price: 6.00, fulfilled: true)
      @order_item_22 = @order_7.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_23 = @order_7.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_24 = @order_7.order_items.create!(item_id: @item_3.id, quantity: 3, price: 3.00, fulfilled: true)
      @order_item_25 = @order_7.order_items.create!(item_id: @item_4.id, quantity: 4, price: 4.00, fulfilled: true)
      @order_item_26 = @order_7.order_items.create!(item_id: @item_5.id, quantity: 5, price: 5.00, fulfilled: true)
      @order_item_27 = @order_7.order_items.create!(item_id: @item_6.id, quantity: 6, price: 6.00, fulfilled: true)
      @order_item_28 = @order_7.order_items.create!(item_id: @item_7.id, quantity: 7, price: 7.00, fulfilled: true)
      @order_item_29 = @order_8.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_30 = @order_8.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_31 = @order_8.order_items.create!(item_id: @item_3.id, quantity: 3, price: 3.00, fulfilled: true)
      @order_item_32 = @order_8.order_items.create!(item_id: @item_4.id, quantity: 4, price: 4.00, fulfilled: true)
      @order_item_33 = @order_8.order_items.create!(item_id: @item_5.id, quantity: 5, price: 5.00, fulfilled: true)
      @order_item_34 = @order_8.order_items.create!(item_id: @item_6.id, quantity: 6, price: 6.00, fulfilled: true)
      @order_item_35 = @order_8.order_items.create!(item_id: @item_7.id, quantity: 7, price: 7.00, fulfilled: true)
      @order_item_36 = @order_8.order_items.create!(item_id: @item_8.id, quantity: 8, price: 8.00, fulfilled: true)

      visit root_path

      click_on "Login"
      fill_in "email", with: @admin.email
      fill_in "password", with: @admin.password
      click_on "Log In"
    end

    it "the page displays all orders in the system" do
      visit admin_dashboard_path

      within ".order-#{@order_1.id}" do
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_link(@order_1.user_name)
      end

      within ".order-#{@order_2.id}" do
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content(@order_2.created_at)
        expect(page).to have_link(@order_2.user_name)
      end

      within ".order-#{@order_3.id}" do
        expect(page).to have_content(@order_3.id)
        expect(page).to have_content(@order_3.created_at)
        expect(page).to have_link(@order_3.user_name)
      end

      within ".order-#{@order_4.id}" do
        expect(page).to have_content(@order_4.id)
        expect(page).to have_content(@order_4.created_at)
        expect(page).to have_link(@order_4.user_name)
      end
    end

    it "the page sorts orders by status" do

      visit admin_dashboard_path

      within ".all-orders" do
        expect("#{@order_3.id}").to appear_before("#{@order_4.id}")
        expect("#{@order_4.id}").to appear_before("#{@order_1.id}")
        expect("#{@order_1.id}").to appear_before("#{@order_5.id}")
        expect("#{@order_5.id}").to appear_before("#{@order_6.id}")
        expect("#{@order_6.id}").to appear_before("#{@order_7.id}")
        expect("#{@order_7.id}").to appear_before("#{@order_8.id}")
      end
    end

    it "I see a link to 'Ship' orders that are packaged" do
      visit admin_dashboard_path

      within ".order-#{@order_3.id}" do
        expect(page).to have_button("Ship")
      end

      within ".order-#{@order_4.id}" do
        expect(page).to have_button("Ship")
      end

      within ".order-#{@order_2.id}" do
        expect(page).to_not have_button("Ship")
      end

      within ".order-#{@order_6.id}" do
        expect(page).to_not have_button("Ship")
      end
    end

    describe "and click 'Ship' beside an order name" do
      it "the order is shipped" do
        visit admin_dashboard_path

        within ".order-#{@order_3.id}" do
          click_button "Ship"

          @order_3.reload

          expect(@order_3.shipped?).to eq(true)
        end

        within ".order-#{@order_4.id}" do
          click_button "Ship"

          @order_4.reload

          expect(@order_4.shipped?).to eq(true)
        end
      end

      it "I see a flash message stating that the order was shipped" do
        visit admin_dashboard_path

        within ".order-#{@order_3.id}" do
          click_button "Ship"
        end

        expect(page).to have_content("Order #{@order_3.id} shipped!")

        within ".order-#{@order_4.id}" do
          click_button "Ship"
        end

        expect(page).to have_content("Order #{@order_4.id} shipped!")
      end
    end

    describe "and click on a user's name" do
      it "I'm taken to that user's profile page" do
        visit admin_dashboard_path

        within ".order-#{@order_1.id}" do
          click_link "#{@order_1.user_name}"

          expect(current_path).to eq(admin_user_path(@order_1.user_id))
        end
      end
    end
  end
end
