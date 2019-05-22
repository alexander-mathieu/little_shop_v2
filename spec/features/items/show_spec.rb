require 'rails_helper'

RSpec.describe "as any kind of user" do
  describe "when I visit an item's show page" do
    before :each do
      @user_1 = User.create!(email: "user_1@gmail.com", role: 2, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "12345")
      @user_2 = User.create!(email: "user_2@gmail.com", role: 2, name: "User 2", address: "User 2 Address", city: "User 1 City", state: "User 1 State", zip: "22345")

      @item_1 = @user_1.items.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://www.warrenhannonjeweler.com/static/images/temp-inventory-landing.jpg", inventory: 10)
      @item_2 = @user_2.items.create!(name: "Item 2", price: 1.50, description: "Item 2 Description", image: "https:/tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
    end

    it "the page displays all information about a single item" do
      visit item_path(@item_1)

      expect(page).to have_css("img[src='#{@item_1.image}']")

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Seller: #{@item_1.user.name}")
      expect(page).to have_content("Available: #{@item_1.inventory}")
      expect(page).to have_content("Price: $#{'%.2f' % @item_1.price}")
      # average amount of time it takes the merchant to fulfill this item
      # link to add to cart if visitor or regular user
    end

    it "the page does not display information about other items" do
      visit item_path(@item_1)

      expect(page).to_not have_css("img[src='#{@item_2.image}']")

      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content("Description: #{@item_2.description}")
      expect(page).to_not have_content("Seller: #{@item_2.user.name}")
      expect(page).to_not have_content("Available: #{@item_2.inventory}")
      expect(page).to_not have_content("Price: $#{'%.2f' % @item_2.price}")
    end

    it "I see a link to add that item to my cart" do
      visit item_path(@item_1)

      expect(page).to have_button("Add to Cart")
    end

    it "I see a dropdown to change the quantity of the item added to my cart" do
      visit item_path(@item_1)

      expect(page).to have_select(:quantity)
    end
  end
end
