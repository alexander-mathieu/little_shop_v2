require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "when I visit the welcome page" do
    it "it displays a navigation bar" do
      visit root_path

      within ".navbar" do
        click_link("Home")

        expect(current_path).to eq(root_path)

        click_link("Items")

        expect(current_path).to eq(items_path)

        click_link("Merchants")

        expect(current_path).to eq(merchants_path)

        click_link("Cart")

        expect(current_path).to eq(cart_path)

        click_link("Login")

        expect(current_path).to eq(login_path)

        click_link("Register")
        
        expect(current_path).to eq(new_user_path)
      end
    end
  end
end
