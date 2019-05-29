require 'rails_helper'

RSpec.describe "As a visitor," do
  describe "I can login on the welcome page" do
    it "and it works I guess" do
      user = User.create!(email: "bob@bob.com", active: true, password: "124355",
        name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

      visit root_path

      click_on "Login"

      expect(current_path).to eq(login_path)
      fill_in "email", with: user.email
      fill_in "password", with: user.password

      click_on "Log In"

      expect(current_path).to eq(profile_path)
    end

    it "and I get rejected if I put the wrong stuff in" do
      user = User.create!(email: "bob@bob.com", password: "124355",
        name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)
      visit root_path

      click_on "Login"

      expect(current_path).to eq(login_path)
      fill_in "email", with: "aaaah"
      fill_in "password", with: user.password

      click_on "Log In"

      expect(current_path).to eq(login_path)
    end

    it "doesnt show a flash If I log in wrong then right" do
      user = User.create!(email: "bob@bob.com", active: true, password: "124355",
        name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

        visit root_path
        click_on "Login"
        fill_in "email", with: "aaaah"
        fill_in "password", with: user.password
        click_on "Log In"
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_on "Log In"
        expect(page).to_not have_content("Some of your information isn't correct.")
    end
  end
end
