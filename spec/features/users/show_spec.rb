# As a registered user
# When I visit my own profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data

require "rails_helper"

describe "as a registered user" do
  describe "when I visit my show page" do

    before :each do
      @user_1 = User.create!(email: "bob@bob.com", password: "124355", name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)
    end

    it "displays_all my data but my PW" do

      visit root_path
      click_link "LogIn"

      fill_in 'email', with: @user_1.email
      fill_in 'password', with: @user_1.password
      click_button "Log In"

      visit profile_path
      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.email)
      expect(page).to have_content(@user_1.address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)
      expect(page).to have_link("Edit my Profile")
    end

    it "does not display for visitors" do
      visit profile_path
      expect(page).to have_no_content(@user_1.name)
      expect(page).to have_content("LogIn")
    end
  end
end
