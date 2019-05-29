require 'rails_helper'

RSpec.describe "as an admin" do
  describe "when I visit a user's order index page" do
    before :each do
      @admin = User.create!(email: "admin@gmail.com", role: 2, name: "Admin", address: "Admin Address", city: "Admin City", state: "Admin State", zip: "22345", password: "123456")
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state: "Merchant 1 State", zip: "32345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state: "Merchant 2 State", zip: "42345", password: "123456")
      @user = User.create!(email: "user@gmail.com", role: 0, name: "User", address: "User Address", city: "User City", state: "User State", zip: "52345", password: "123456", created_at: 4.days.ago)

      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @merchant_2.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)
      @item_4 = @merchant_2.items.create!(name: "Item 4", active: true, price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 25)

      @order_1 = @user.orders.create!(status: 0)
      @order_2 = @user.orders.create!(status: 0)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_4 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 2.00, fulfilled: true)

      visit root_path

      click_on "Login"
      fill_in "email", with: @admin.email
      fill_in "password", with: @admin.password
      click_on "Log In"
    end

    it "displays all user's orders" do
      visit admin_user_orders_path(@user)

      within "#Order-#{@order_1.id}" do
        expect(page).to have_content("Order #{@order_1.id}")
        expect(page).to have_content("Placed: #{@order_1.created_at.to_date}")
        expect(page).to have_content("Updated: #{@order_1.updated_at.to_date}")
        expect(page).to have_content("Status: #{@order_1.status}")
        expect(page).to have_content("Number of Items: #{@order_1.total_item_count}")
        expect(page).to have_content("Order Cost: #{@order_1.total_price}")
      end

      within "#Order-#{@order_2.id}" do
        expect(page).to have_content("Order #{@order_2.id}")
        expect(page).to have_content("Placed: #{@order_2.created_at.to_date}")
        expect(page).to have_content("Updated: #{@order_2.updated_at.to_date}")
        expect(page).to have_content("Status: #{@order_2.status}")
        expect(page).to have_content("Number of Items: #{@order_2.total_item_count}")
        expect(page).to have_content("Order Cost: #{@order_2.total_price}")
      end
    end
  end
end
