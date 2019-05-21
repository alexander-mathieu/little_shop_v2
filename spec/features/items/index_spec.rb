require 'rails_helper'

RSpec.describe "as a user" do
  describe "when I visit /items" do
    before :each do
      @user_1 = User.create!(email: "user_1@gmail.com", role: 2, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "12345")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 2, name: "User 2", address: "User 2 Address", city: "User 1 City", state: "User 1 State", zip: "22345")
      @user_3 = User.create!(email: "user_3@gmail.com", role: 2, name: "User 3", address: "User 3 Address", city: "User 1 City", state: "User 1 State", zip: "32345")
      @user_4 = User.create!(email: "user_4@gmail.com", role: 2, name: "User 4", address: "User 4 Address", city: "User 1 City", state: "User 1 State", zip: "42345")

      @item_1 = @user_1.items.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @user_1.items.create!(name: "Item 2", price: 1.50, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @user_2.items.create!(name: "Item 3", price: 2.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)
      @item_4 = @user_2.items.create!(name: "Item 4", price: 2.50, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 25)
      @item_5 = @user_3.items.create!(name: "Item 5", price: 3.00, description: "Item 5 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 30)
      @item_6 = @user_3.items.create!(name: "Item 6", price: 3.50, description: "Item 6 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 35)
      @item_7 = @user_4.items.create!(name: "Item 7", price: 4.00, description: "Item 7 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 40)
      @item_8 = @user_4.items.create!(name: "Item 8", price: 4.50, description: "Item 8 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 45)
    end

    it "the page displays a list of all items in the system with information" do
      visit items_path

      within ".item-#{@item_1.id}-info" do
        expect(page).to have_link(@item_1.name)
        # image link test
        expect(page).to have_css("img[src='#{@item_1.image}']")
        expect(page).to have_content(@item_1.user)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content(@item_1.price)
      end

      within ".item-#{@item_2.id}-info" do
        expect(page).to have_link(@item_2.name)
        # image link test
        expect(page).to have_css("img[src='#{@item_2.image}']")
        expect(page).to have_content(@item_2.user)
        expect(page).to have_content(@item_2.inventory)
        expect(page).to have_content(@item_2.price)
      end

      within ".item-#{@item_3.id}-info" do
        expect(page).to have_link(@item_3.name)
        # image link test
        expect(page).to have_css("img[src='#{@item_3.image}']")
        expect(page).to have_content(@item_3.user)
        expect(page).to have_content(@item_3.inventory)
        expect(page).to have_content(@item_3.price)
      end

      within ".item-#{@item_4.id}-info" do
        expect(page).to have_link(@item_4.name)
        # image link test
        expect(page).to have_css("img[src='#{@item_4.image}']")
        expect(page).to have_content(@item_4.user)
        expect(page).to have_content(@item_4.inventory)
        expect(page).to have_content(@item_4.price)
      end
    end

    it "I'm able to navigate to an item's show page by clicking its name" do
      visit items_path

      within ".item-#{@item_1.id}-info" do
        click_link(@item_1.name)
      end

      expect(current_path).to eq(item_path(@item_1))
    end

    # it "I'm able to navigate to an item's show page by clicking its picture" do
    #   visit items_path
    #
    #   within ".item-#{@item_1.id}-info" do
    #     click_link(@item_1.name)
    #   end
    #
    #   expect(current_path).to eq(item_path(@item_1))
    # end
  end
end
