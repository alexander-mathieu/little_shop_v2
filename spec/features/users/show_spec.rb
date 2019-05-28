require "rails_helper"

RSpec.describe "when I visit a user's profile page" do
  before :each do
    @merchant = User.create!(email: "merchant@gmail.com", active: true, role: 1, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "12345", password: "123456")
    @user_1 = User.create!(email: "user_1@gmail.com", active: true, role: 0, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "22345", password: "123456")
    @user_2 = User.create!(email: "user_2@gmail.com", active: true, role: 0, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "32345", password: "123456")

    @item_1 = @merchant.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
    @item_2 = @merchant.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
    @item_3 = @merchant.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)

    @order_1 = @user_1.orders.create!(status: 3)
    @order_2 = @user_1.orders.create!(status: 3)

    @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
    @order_item_2 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
    @order_item_3 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
    @order_item_4 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
    @order_item_5 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
  end

  context "as that user" do
    before :each do
      visit root_path

      click_link "Login"

      fill_in 'email', with: @user_1.email
      fill_in 'password', with: @user_1.password

      click_button "Log In"
    end

    it "the page displays all my data but my password" do
      visit profile_path

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.email)
      expect(page).to have_content(@user_1.address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)

      expect(page).to have_link("Edit my Profile")
    end

    it "the page displays a link to my orders" do
      visit profile_path

      click_link "My Orders"

      expect(current_path).to eq(profile_orders_path)
    end
  end

  context "as a visitor" do
    it "I recieve a 404 error" do
      visit profile_path

      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
