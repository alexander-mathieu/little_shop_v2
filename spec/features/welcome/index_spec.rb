require 'rails_helper'

###Tests for navbar showing number of items in cart are in cart_show reature spec

RSpec.describe "when I visit the welcome page" do
  context "as a visitor" do
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

        click_link("LogIn")
        expect(current_path).to eq(login_path)

        click_link("Register")
        expect(current_path).to eq(register_path)
      end
    end
  end

  context "as a registered user" do
    it "lets a user log out" do
      user = User.create!(email: "bob@bob.com", password: "124355", name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

      visit root_path

      click_on "LogIn"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Log In"

      within ".navbar" do
        click_link("Logout")

        expect(current_path).to eq(root_path)
      end
      expect(page).to have_content("You are now logged out")
    end

    it "gives me different options as a user" do
      user = User.create!(email: "bob@bob.com", password: "124355", name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

      visit root_path

      click_on "LogIn"
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

        click_link("Cart")
        expect(current_path).to eq(cart_path)
        expect(page).to_not have_link("LogIn")
        expect(page).to_not have_link("Register")

        click_link("Profile")
        expect(current_path).to eq(profile_path)

        click_link("Logout")
        expect(current_path).to eq(root_path)
        expect(page).to have_link("LogIn")
        expect(page).to have_link("Register")
      end
    end

    it "directs to a users profile if already logged in" do
      user = User.create!(email: "bob@bob.com", password: "124355", name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

      visit root_path

      click_on "LogIn"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Log In"
      visit "/login"

      expect(current_path).to eq(profile_path)
    end
  end

  context "as a merchant" do
    before :each do
      @merchant = User.create!(email: "joe@joe.com", password: "124355",
        name: "joe", role: 1, address:"123 joe st.", city: "joeton", state:"MI", zip: 28334)

      visit root_path

      click_on "LogIn"
      fill_in "email", with: @merchant.email
      fill_in "password", with: @merchant.password
      click_on "Log In"
    end

    it "shows me the same links as a visitor" do
      click_link("Home")
      expect(current_path).to eq(root_path)

      click_link("Items")
      expect(current_path).to eq(items_path)

      click_link("Merchants")
      expect(current_path).to eq(merchants_path)
    end

    it "also shows the logout and dashboard" do
      visit root_path

      click_link("Dashboard")
      expect(current_path).to eq(dashboard_path)

      click_link("Logout")
      expect(current_path).to eq(root_path)
    end

    it "doesnt show login/register or cart" do
      visit root_path

      expect(page).to_not have_link("LogIn")
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("Cart")
    end
  end

  context "as an admin" do
    before :each do
      @admin = User.create!(email: "admin@gmail.com", password: "124356", name: "Admin", role: 2, address: "Admin Address", city: "Admin City", state: "MA", zip: 28334)

      visit root_path

      click_on "LogIn"
      fill_in "email", with: @admin.email
      fill_in "password", with: @admin.password
      click_on "Log In"
    end

    it "the page doesn't display a link to my cart or item count" do
      visit root_path

      within ".navbar" do
        expect(page).to_not have_link("Cart")
        expect(page).to_not have_content("Items in cart")
      end
    end

    it "the page displays a link to my admin dashboard" do
      visit root_path

      within ".navbar" do
        expect(page).to have_link("Dashboard")

        click_link("Dashboard")

        expect(current_path).to eq(admin_dashboard_path)
      end
    end
  end
end

#   As a merchant user
# I see the same links as a visitor
# Plus the following links:
# - a link to my merchant dashboard ("/dashboard")
# - a link to log out ("/logout")
#
# Minus the following links/info:
# - I do not see a link to log in or register
# - a link to my shopping cart ("/cart") or count of cart items
# end
