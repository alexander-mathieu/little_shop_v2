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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit profile_path
      click_link "Edit my Profile"
      expect(current_path).to eq(profile_path)
      expect(find_field('user_name').value).to eq('bob')
      expect(find_field('user_email').value).to eq('bob@bob.com')
      expect(find_field('user_address').value).to eq('123 bob st.')
      expect(find_field('user_city').value).to eq('bobton')
      expect(find_field('user_state').value).to eq('MA')
      expect(find_field('user_zip').value).to eq("28234")
      expect(find_field('user_password_digest').value).to eq(nil)

      fill_in 'user_name', with: 'George'
      fill_in 'user_city', with: 'georgeville'

      click_button "Change my Profile"
        expect(current_path).to eq(user_path(@user_1))

    end

  end

end
