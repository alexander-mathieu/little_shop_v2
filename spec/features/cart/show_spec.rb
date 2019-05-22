require 'rails_helper'

RSpec.describe "As a user," do
  describe "when I visit my cart" do
    before :each do
      itemA = Item.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      itemB = Item.create!(name: "Item 2", price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 11)
      itemC = Item.create!(name: "Item 3", price: 2.50, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 12)
    end

    it "I see something telling me it's empty (if it's empty)" do
      visit "/cart"

      expect(page).to have_content("Your cart is empty.")
    end

    it "I can add an item to my cart" do
      visit "/items/#{itemA.id}"
      click_on "Add"

      expect(current_path).to eq("/items/#{itemA.id}")


    end

    it "I see a list of items and quantities" do

    end
  end
end