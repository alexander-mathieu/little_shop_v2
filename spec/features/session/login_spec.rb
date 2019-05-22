require 'rails_helper'

RSpec.describe "As a visitor," do
  describe "I can login on the welcome page" do
    it "and it works I guess" do
      user = User.create!(email: "bob@bob.com", password: "124355",
        name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

      visit root_path

      click_on "login?"

      expect(current_path).to eq(login_path)
      fill_in "email", with: user.email
      fill_in "password", with: user.password

      click_on "Log In"

      expect(current_path).to eq(profile_path)
    end
  end
end
