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

        # click_link("Cart")
        #
        # expect(current_path).to eq(cart_path)

        click_link("Login")
        expect(current_path).to eq(login_path)
        click_link("Register")
        expect(current_path).to eq(new_user_path)
      end
    end
#     As a registered user, merchant, or admin
# When I visit the logout path
# I am redirected to the welcome / home page of the site
# And I see a flash message that indicates I am logged out
# Any items I had in my shopping cart are deleted

    it "lets a user log out" do
      user = User.create!(email: "bob@bob.com", password: "124355",
        name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)
      visit root_path
      click_on "login?"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Log In"

      within ".navbar" do
        click_link("Logout")
        expect(current_path).to eq(root_path)
      end
      expect(page).to have_content("You are now logged Out")

    end

      it "gives me different options as a user" do
        user = User.create!(email: "bob@bob.com", password: "124355",
          name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)
        visit root_path
        click_on "login?"
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_on "Log In"


        within ".navbar" do
        click_link("Home")
        expect(current_path).to eq(root_path)
        click_link("Items")
        expect(current_path).to eq(items_path)
        click_link("Merchants")
        expect(current_path).to eq(merchants_path)
        # click_link("Cart")
        # expect(current_path).to eq(cart_path)
        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")
        click_link("Profile")
        expect(current_path).to eq(profile_path)
        click_link("Logout")
        expect(current_path).to eq(root_path)
        expect(page).to have_link("Login")
        expect(page).to have_link("Register")
      end
    end

  end
end
