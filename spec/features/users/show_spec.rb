# As a registered user
# When I visit my own profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data

require "rails_helper"

describe "as a registered user" do
  describe "when I visit my show page" do
    it "displays_all my data but my PW" do
      user_1 = User.create(email: "bob@bob.com", password_digest: 1243, name: "bob", address:"123 bob st.", city: "bobton", state:"MA", zip: 28234)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit user_path(user_1)

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.email)
      expect(page).to have_content(user_1.address)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.zip)

      expect(page).to have_link("Edit my Profile")

    end

  end

end
