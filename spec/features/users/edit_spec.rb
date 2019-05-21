# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# Then my current URI route is "/profile/edit"
# I see a form like the registration page
# The form contains all of my user information
# The password fields are blank and can be left blank
# I can change any or all of the information
# When I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information

require "rails_helper"

describe "as a user" do
  describe "when I visit my profile page" do
    before :each do
        @user_1 = User.create(email: "bob@bob.com", password_digest: 1243, name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)
    end
    it "lets me edit my info" do
      visit user_path(@user_1)
      click_link "Edit My Profile"
      expect(current_path).to eq(edit_user_path(@user_1))
    end

  end

end
