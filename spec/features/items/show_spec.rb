require 'rails_helper'

RSpec.describe "when I visit an item's show page" do
  describe "as any kind of user" do
    before :each do
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state: "Merchant 1 State", zip: "12345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state: "Merchant 2 State", zip: "22345", password: "123456")
      @user_1 = User.create!(email: "user_1@gmail.com", role: 0, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "32345", password: "123456")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 0, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "42345", password: "123456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://www.warrenhannonjeweler.com/static/images/temp-inventory-landing.jpg", inventory: 10)
      @item_2 = @merchant_2.items.create!(name: "Item 2", price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)

      @order_1 = @user_1.orders.create!(status: 3)
      @order_2 = @user_1.orders.create!(status: 3)
      @order_3 = @user_2.orders.create!(status: 3)
      @order_4 = @user_2.orders.create!(status: 3)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
      @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true, created_at: 8.days.ago, updated_at: 2.days.ago)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
      @order_item_4 = @order_2.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true, created_at: 8.days.ago, updated_at: 2.days.ago)
      @order_item_5 = @order_3.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
      @order_item_6 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true, created_at: 8.days.ago, updated_at: 2.days.ago)
      @order_item_7 = @order_4.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true, created_at: 9.days.ago, updated_at: 1.days.ago)
      @order_item_8 = @order_4.order_items.create!(item_id: @item_2.id, quantity: 2, price: 4.00, fulfilled: true, created_at: 8.days.ago, updated_at: 2.days.ago)
    end

    it "the page displays all information about a single item" do
      visit item_path(@item_1)

      expect(page).to have_css("img[src='#{@item_1.image}']")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Seller: #{@item_1.user.name}")
      expect(page).to have_content("Available: #{@item_1.inventory}")
      expect(page).to have_content("Price: $#{'%.2f' % @item_1.price}")
      expect(page).to have_content("Average Fulfillment Time: #{@item_1.average_fulfillment_time} days")
    end

    it "the page does not display information about other items" do
      visit item_path(@item_1)

      expect(page).to_not have_css("img[src='#{@item_2.image}']")

      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content("Description: #{@item_2.description}")
      expect(page).to_not have_content("Seller: #{@item_2.user.name}")
      expect(page).to_not have_content("Available: #{@item_2.inventory}")
      expect(page).to_not have_content("Price: $#{'%.2f' % @item_2.price}")
      expect(page).to_not have_content("Average Fulfillment Time: #{@item_2.average_fulfillment_time} days")
    end
  end

  describe "as an admin" do
    before :each do
      @merchant = User.create!(email: "merchant@gmail.com", role: 1, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "12345", password: "123456")
      @admin = User.create!(email: "admin@gmail.com", role: 2, name: "Admin", address: "Admin Address", city: "Admin City", state: "Admin State", zip: "22345", password: "123456")

      @item = @merchant.items.create!(name: "Item", price: 2.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
    end

    it "I do not see add-to-cart functionality" do
      visit login_path

      fill_in :email, with: "admin@gmail.com"
      fill_in :password, with: "123456"

      click_button "Log In"

      visit item_path(@item)

      expect(page).to_not have_select(:quantity)
      expect(page).to_not have_button("Add to Cart")
    end
  end

  describe "as a merchant" do
    before :each do
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state: "Merchant 1 State", zip: "12345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state: "Merchant 2 State", zip: "22345", password: "123456")

      @item = @merchant_2.items.create!(name: "Item", price: 2.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
    end

    it "I do not see add-to-cart functionality" do
      visit login_path

      fill_in :email, with: "merchant_1@gmail.com"
      fill_in :password, with: "123456"

      click_button "Log In"

      visit item_path(@item)

      expect(page).to_not have_select(:quantity)
      expect(page).to_not have_button("Add to Cart")
    end
  end
end
