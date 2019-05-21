require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click on the register link in the nav bar' do
    it 'then I am on the registration page' do
      visit root_path
      click_on "Register"

      expect(current_path).to eq(new_user_path)
    end

    it 'I can create a new user when I fill in the new user form completely with a unique email address' do
      visit new_user_path

      fill_in "user[name]", with: "John Smith"
      fill_in "user[address]", with: "1234 Main St"
      fill_in "user[city]", with: "Beverly Hills"
      select("CA", from: "user[state]")
      fill_in "user[zip]", with: "90210"
      fill_in "user[email]", with: "john.smith@example.com"
      fill_in "user[password]", with: "abcd1234"
      fill_in "user[password_confirmation]", with: "abcd1234"

      click_on "Sign Up"

      new_user = User.last
      #change to profile_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{new_user.name}. You are now registered and logged in!")
    end

  end
end
