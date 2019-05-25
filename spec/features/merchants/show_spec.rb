require 'rails_helper'
describe "as a merchant" do
  describe "when I visit my dashboard page" do
    before :each do
      @merchant1 = create(:merchant, email: "m1@gmail.com")
      @user1 = create(:user, email: "u1@gmail.com")
    end

    it "Shows my profile data, but cannot edit it" do
      visit root_path

      click_link "LogIn"
      fill_in 'email', with: @merchant1.email
      fill_in 'password', with: @merchant1.password
      click_button "Log In"

      click_link "Dashboard"
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant1.email)
      expect(page).to have_content(@merchant1.address)
      expect(page).to have_content(@merchant1.city)
      expect(page).to have_content(@merchant1.state)
      expect(page).to have_content(@merchant1.zip)
    end

    it "does not display for visitors or users" do
      visit root_path
      expect(page).to have_no_link("Dashboard")

      click_link "LogIn"
      fill_in 'email', with: @user1.email
      fill_in 'password', with: @user1.password
      click_button "Log In"

      expect(page).to have_no_link("Dashboard")

      visit root_path
      expect(page).to have_no_link("Dashboard")
    end
  end
end
