require 'rails_helper'

RSpec.describe "As a user," do
  describe "when I visit my cart" do
    before :each do
      @user = User.create!(email: "bob@bob.com", password: "124355", name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)
      @itemA = @user.items.create!(name: "Item 1", price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @itemB = @user.items.create!(name: "Item 2", price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 11)
      @itemC = @user.items.create!(name: "Item 3", price: 2.50, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 12)
      visit "/items/#{@itemA.id}"
      page.select '1', from: :quantity
      click_on "Add to Cart"
      visit "/items/#{@itemB.id}"
      page.select '5', from: :quantity
      click_on "Add to Cart"
      visit "/items/#{@itemC.id}"
      page.select '2', from: :quantity
      click_on "Add to Cart"

      visit "/cart"
    end

    it "I see a list of items and quantities" do
      within ".navbar" do
        expect(page).to have_content("8 Items in cart")
      end
      expect(page).to have_content("#{@itemA.name}: 1")
      expect(page).to have_content("#{@itemB.name}: 5")
      expect(page).to have_content("#{@itemC.name}: 2")
    end

    it "I can empty my cart" do
      click_on "Empty"

      expect(page).to_not have_content("#{@itemA.name}: 2")
      expect(page).to_not have_content("#{@itemB.name}: 5")
      expect(page).to_not have_content("#{@itemC.name}: 1")
    end

    it "I see something telling me it's empty (if it's empty)" do
      click_on "Empty"

      expect(page).to have_content("Your cart is empty.")
      within ".navbar" do
        expect(page).to have_content("0 Items in cart")
      end
    end

    it "I can change the quantity in my cart" do
      within "#cart-item-#{@itemB.id}" do
        page.select '3', from: :quantity
        click_on "Change"
      end

      expect(page).to have_content("#{@itemB.name}: 3")
    end

    it "I can add an item after changing" do
      within "#cart-item-#{@itemB.id}" do
        page.select '3', from: :quantity
        click_on "Change"
      end
      visit "/items/#{@itemB.id}"
      page.select '1', from: :quantity
      click_on "Add to Cart"
      visit "/cart"

      expect(page).to have_content("#{@itemB.name}: 4")
    end

    it "I can remove an item from my cart" do
      within "#cart-item-#{@itemB.id}" do
        click_on "Remove"
      end

      expect(page).to_not have_content("#{@itemB.name}: 5")
    end

    it "I see a login prompt if I'm not logged in" do
      expect(page).to have_content("You must login or register to check out.")
    end

    it "gives me a check out option if I'm logged in" do
      click_on "LogIn"
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_on "Log In"

      visit '/cart' #TECHNICAL DEBT LOL
      expect(current_path).to eq('/cart')
      expect(page).to have_content("Check Out")
    end
  end
end
