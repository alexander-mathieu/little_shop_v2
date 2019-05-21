require 'rails_helper'

RSpec.describe "As a visitor, " do
  describe "I can login on the welcome page" do
    user = User.create(email: "help@gmail.com", password: "12345")

    visit root_path

    click_on "login?"

    expect(current_path).to eq(login_path)
    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "Log In"

    expect(current_path).to eq(user_path(user))
  end
end