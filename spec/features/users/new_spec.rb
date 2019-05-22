require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click on the register link in the nav bar' do
    it 'then I am on the registration page' do
      visit root_path
      click_on "Register"

      expect(current_path).to eq(register_path)
    end

    it 'I can create a new user when I fill in the new user form completely with a unique email address' do
      visit register_path

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

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome, #{new_user.name}. You are now registered and logged in!")
    end

    it 'I can not create a new user when I do not fill in the new user form completely' do
      visit register_path

      fill_in "user[name]", with: "John Smith"
      fill_in "user[address]", with: ""
      fill_in "user[city]", with: "Beverly Hills"
      select("CA", from: "user[state]")
      fill_in "user[zip]", with: "90210"
      fill_in "user[email]", with: "john.smith@example.com"
      fill_in "user[password]", with: "abcd1234"
      fill_in "user[password_confirmation]", with: "abcd1234"

      click_on "Sign Up"

      expect(current_path).to eq(users_path)
      expect(find_field('user[name]').value).to eq 'John Smith'
      expect(find_field('user[email]').value).to eq 'john.smith@example.com'
      expect(find_field('user[zip]').value).to eq '90210'
      expect(page).to have_content("You are missing required fields, your email is already in use, or your passwords don't match.")
    end

    it 'I can not create a new user when the email address is already in the system' do
      user = User.create!(name: "Jonathan Smith", address: "9876 Main St", city: "Lakewood", state: "CO", zip: "80226", email: "john.smith@example.com", password: "123456")

      visit register_path

      fill_in "user[name]", with: "John Smith"
      fill_in "user[address]", with: "1234 Main St"
      fill_in "user[city]", with: "Beverly Hills"
      select("CA", from: "user[state]")
      fill_in "user[zip]", with: "90210"
      fill_in "user[email]", with: "john.smith@example.com"
      fill_in "user[password]", with: "abcd1234"
      fill_in "user[password_confirmation]", with: "abcd1234"

      click_on "Sign Up"

      expect(current_path).to eq(users_path)
      expect(find_field('user[name]').value).to eq 'John Smith'
      expect(find_field('user[email]').value).to eq 'john.smith@example.com'
      expect(find_field('user[zip]').value).to eq '90210'
      expect(page).to have_content("You are missing required fields, your email is already in use, or your passwords don't match.")
    end

    it 'I can not create a new user when the password does not match confirm password' do
      visit register_path

      fill_in "user[name]", with: "John Smith"
      fill_in "user[address]", with: "1234 Main St"
      fill_in "user[city]", with: "Beverly Hills"
      select("CA", from: "user[state]")
      fill_in "user[zip]", with: "90210"
      fill_in "user[email]", with: "john.smith@example.com"
      fill_in "user[password]", with: "abcd1234"
      fill_in "user[password_confirmation]", with: "aBcd1234"

      click_on "Sign Up"

      expect(current_path).to eq(users_path)
      expect(find_field('user[name]').value).to eq 'John Smith'
      expect(find_field('user[email]').value).to eq 'john.smith@example.com'
      expect(find_field('user[zip]').value).to eq '90210'
      expect(page).to have_content("You are missing required fields, your email is already in use, or your passwords don't match.")
    end
  end
end
