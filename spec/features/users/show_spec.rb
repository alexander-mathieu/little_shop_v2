# As a registered user
# When I visit my own profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data

require "rails_helper"

describe "as a registered user" do
  describe "when I visit my show page" do

    before :each do
      @user_1 = User.create!(email: "user_1@gmail.com", role: 2, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "12345", password: "123456")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 2, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "22345", password: "123456")

      @user_8 = User.create!(email: "user_8@gmail.com", role: 0, name: "User 8", address: "User 8 Address", city: "User 8 City", state: "User 8 State", zip: "82345", password: "123456")

      @item_1 = @user_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @user_2.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @user_2.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)

      @order_1 = @user_8.orders.create!(status: 3)
      @order_2 = @user_8.orders.create!(status: 3)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)
      @order_item_4 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)
      @order_item_5 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true)

    end

    it "displays_all my data but my PW" do

      visit root_path
      click_link "LogIn"

      fill_in 'email', with: @user_8.email
      fill_in 'password', with: @user_8.password
      click_button "Log In"

      visit profile_path
      expect(page).to have_content(@user_8.name)
      expect(page).to have_content(@user_8.email)
      expect(page).to have_content(@user_8.address)
      expect(page).to have_content(@user_8.city)
      expect(page).to have_content(@user_8.state)
      expect(page).to have_content(@user_8.zip)
      expect(page).to have_link("Edit my Profile")
    end

    it "does not display for visitors" do
      visit profile_path
      expect(page).to have_no_content(@user_8.name)
      expect(page).to have_content("LogIn")
    end

    it "shows me a link to my orders" do

      visit root_path
      click_link "LogIn"

      fill_in 'email', with: @user_8.email
      fill_in 'password', with: @user_8.password
      click_button "Log In"

      click_link "My Orders"
      expect(current_path).to eq(profile_orders_path)
    end
  end
end
