require 'rails_helper'

RSpec.describe "as a user" do
  describe "when I visit /items" do
    before :each do
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state: "Merchant 1 State", zip: "12345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state: "Merchant 2 State", zip: "22345", password: "123456")
      @merchant_3 = User.create!(email: "merchant_3@gmail.com", role: 1, name: "Merchant 3", address: "Merchant 3 Address", city: "Merchant 3 City", state: "Merchant 3 State", zip: "32345", password: "123456")
      @merchant_4 = User.create!(email: "merchant_4@gmail.com", role: 1, name: "Merchant 4", address: "Merchant 4 Address", city: "Merchant 4 City", state: "Merchant 4 State", zip: "42345", password: "123456")
      @user_1= User.create!(email: "user_1@gmail.com", role: 0, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "52345", password: "123456")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 0, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "62345", password: "123456")
      @user_3 = User.create!(email: "user_3@gmail.com", role: 0, name: "User 3", address: "User 3 Address", city: "User 3 City", state: "User 3 State", zip: "72345", password: "123456")
      @user_4 = User.create!(email: "user_4@gmail.com", role: 0, name: "User 4", address: "User 4 Address", city: "User 4 City", state: "User 4 State", zip: "82345", password: "123456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @merchant_2.items.create!(name: "Item 2", price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @merchant_2.items.create!(name: "Item 3", price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)
      @item_4 = @merchant_3.items.create!(name: "Item 4", price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 25)
      @item_5 = @merchant_3.items.create!(name: "Item 5", price: 5.00, description: "Item 5 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 30)
      @item_6 = @merchant_3.items.create!(name: "Item 6", price: 6.00, description: "Item 6 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 35)
      @item_7 = @merchant_4.items.create!(name: "Item 7", price: 7.00, description: "Item 7 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 40)
      @item_8 = @merchant_4.items.create!(name: "Item 8", price: 8.00, description: "Item 8 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 45)
      @item_9 = @merchant_4.items.create!(name: "Item 9", price: 9.00, description: "Item 9 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 50)
      @item_10 = @merchant_4.items.create!(name: "Item !0", price: 10.00, description: "Item 10 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 55)

      @order_1 = @user_1.orders.create!(status: 3)
      @order_2 = @user_1.orders.create!(status: 3)
      @order_3 = @user_2.orders.create!(status: 3)
      @order_4 = @user_2.orders.create!(status: 3)
      @order_5 = @user_3.orders.create!(status: 3)
      @order_6 = @user_3.orders.create!(status: 3)
      @order_7 = @user_4.orders.create!(status: 3)
      @order_8 = @user_4.orders.create!(status: 3)

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
    end

    it "the page displays a list of all items in the system with information" do
      visit items_path

      within ".item-#{@item_1.id}-info" do
        expect(page).to have_css("img[src='#{@item_1.image}']")

        expect(page).to have_link(@item_1.name)
        expect(page).to have_link("#{@item_1.name}-image")

        expect(page).to have_content("Seller: #{@item_1.user.name}")
        expect(page).to have_content("Available: #{@item_1.inventory}")
        expect(page).to have_content("Price: $#{'%.2f' % @item_1.price}")
      end

      within ".item-#{@item_2.id}-info" do
        expect(page).to have_css("img[src='#{@item_2.image}']")

        expect(page).to have_link(@item_2.name)
        expect(page).to have_link("#{@item_2.name}-image")

        expect(page).to have_content("Seller: #{@item_2.user.name}")
        expect(page).to have_content("Available: #{@item_2.inventory}")
        expect(page).to have_content("Price: $#{'%.2f' % @item_2.price}")
      end

      within ".item-#{@item_3.id}-info" do
        expect(page).to have_css("img[src='#{@item_3.image}']")

        expect(page).to have_link(@item_3.name)
        expect(page).to have_link("#{@item_3.name}-image")

        expect(page).to have_content("Seller: #{@item_3.user.name}")
        expect(page).to have_content("Available: #{@item_3.inventory}")
        expect(page).to have_content("Price: $#{'%.2f' % @item_3.price}")
      end

      within ".item-#{@item_4.id}-info" do
        expect(page).to have_css("img[src='#{@item_4.image}']")

        expect(page).to have_link(@item_4.name)
        expect(page).to have_link("#{@item_4.name}-image")

        expect(page).to have_content("Seller: #{@item_4.user.name}")
        expect(page).to have_content("Available: #{@item_4.inventory}")
        expect(page).to have_content("Price: $#{'%.2f' % @item_4.price}")
      end
    end

    it "I'm able to navigate to an item's show page by clicking its name" do
      visit items_path

      within ".item-#{@item_1.id}-info" do
        click_link(@item_1.name)
      end

      expect(current_path).to eq(item_path(@item_1))
    end

    it "I'm able to navigate to an item's show page by clicking its picture" do
      visit items_path

      within ".item-#{@item_1.id}-info" do
        click_link("#{@item_1.name}-image")
      end

      expect(current_path).to eq(item_path(@item_1))
    end

    it "I see a section of the page for item statistics" do
      visit items_path

      expect(page).to have_css(".item-stats")
    end

    it "I see the top 5 most popular items by quantity purchased with quantity bought" do
      visit items_path

      within ".item-stats" do
        within ".most-popular" do
          expect(@item_4.name).to appear_before(@item_5.name)
          expect(@item_5.name).to appear_before(@item_3.name)
          expect(@item_3.name).to appear_before(@item_6.name)
          expect(@item_6.name).to appear_before(@item_2.name)
        end
      end
    end

    it "I see the top 5 least popular items by quantity purchased with quantity bought" do
      visit items_path

      within ".item-stats" do
        within ".least-popular" do
          expect(@item_10.name).to appear_before(@item_9.name)
          expect(@item_9.name).to appear_before(@item_1.name)
          expect(@item_1.name).to appear_before(@item_8.name)
          expect(@item_8.name).to appear_before(@item_2.name)
        end
      end
    end
  end
end
