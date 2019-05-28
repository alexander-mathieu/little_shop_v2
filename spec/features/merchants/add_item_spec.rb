require 'rails_helper'

describe "as a merchant" do
  describe "when I visit my dashboard page" do
    before :each do
      @merchant = create(:merchant, email: "m1@gmail.com")
      visit root_path

      click_link "Login"
      fill_in 'email', with: @merchant.email
      fill_in 'password', with: @merchant.password
      click_button "Log In"

      click_link "Dashboard"
      expect(current_path).to eq(dashboard_path)

      click_link "Add Item"
      expect(current_path).to eq(new_item_path)
    end

    it "I can add an item" do
      fill_in 'item[name]', with: "New Item"
      fill_in 'item[price]', with: "4.50"
      fill_in 'item[description]', with: "heck"
      fill_in 'item[inventory]', with: "5"
      click_on "Add Item"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Item Added.")
      expect(page).to have_content("New Item")
    end

    it "doesn't add item if I do a bad" do
      fill_in 'item[price]', with: "4.50"
      fill_in 'item[description]', with: "heck"
      fill_in 'item[inventory]', with: "5"
      click_on "Add Item"
      expect(current_path).to eq(new_item_path)
      expect(page).to have_content("Invalid input.")
      visit '/dashboard'
      expect(page).to_not have_content("heck")
    end
  end
end
