require 'rails_helper'

RSpec.describe "as an admin" do
  describe "when I visit the users index page" do
    before :each do
      @admin_1 = User.create!(email: "admin_1@gmail.com", role: 2, name: "Admin 1", address: "Admin 1 Address", city: "Admin 1 City", state: "Admin 1 State", zip: "12345", password: "123456")
      @admin_2 = User.create!(email: "admin_2@gmail.com", role: 2, name: "Admin 2", address: "Admin 2 Address", city: "Admin 2 City", state: "Admin 2 State", zip: "22345", password: "123456")
      @merchant_1 = User.create!(email: "merchant_1@gmail.com", role: 1, name: "Merchant 1", address: "Merchant 1 Address", city: "Merchant 1 City", state: "Merchant 1 State", zip: "32345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant 2", address: "Merchant 2 Address", city: "Merchant 2 City", state: "Merchant 2 State", zip: "42345", password: "123456")
      @user_1 = User.create!(email: "user_1@gmail.com", role: 0, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State", zip: "52345", password: "123456", created_at: 4.days.ago)
      @user_2 = User.create!(email: "user_2@gmail.com", role: 0, name: "User 2", address: "User 2 Address", city: "User 2 City", state: "User 2 State", zip: "62345", password: "123456", created_at: 3.days.ago)
      @user_3 = User.create!(email: "user_3@gmail.com", role: 0, name: "User 3", address: "User 3 Address", city: "User 3 City", state: "User 3 State", zip: "72345", password: "123456", created_at: 2.days.ago)
      @user_4 = User.create!(email: "user_4@gmail.com", role: 0, name: "User 4", address: "User 4 Address", city: "User 4 City", state: "User 4 State", zip: "82345", password: "123456", created_at: 1.days.ago)

      visit root_path

      click_on "Login"
      fill_in "email", with: @admin_1.email
      fill_in "password", with: @admin_1.password
      click_on "Log In"
    end

    it "it displays all users in the system who are not merchants or admins" do
      visit admin_users_path

      within ".all-default-users" do
        expect(page).to have_content(@user_1.name)
        expect(page).to have_content(@user_2.name)
        expect(page).to have_content(@user_3.name)
        expect(page).to have_content(@user_4.name)
      end

      within ".all-default-users" do
        expect(page).to_not have_content(@admin_2.name)
        expect(page).to_not have_content(@merchant_1.name)
        expect(page).to_not have_content(@merchant_2.name)
      end
    end

    it "I see each user's name as a link to a show page for that user" do
      visit admin_users_path

      within ".all-default-users" do
        expect(page).to have_link(@user_1.name)
        expect(page).to have_link(@user_2.name)
        expect(page).to have_link(@user_3.name)
        expect(page).to have_link(@user_4.name)
      end
    end

    it "I see the date each user registered beside their name" do
      visit admin_users_path

      within ".all-default-users" do
        within ".default-user-#{@user_1.id}" do
          expect(page).to have_content("Joined: #{@user_1.created_at}")
        end

        within ".default-user-#{@user_2.id}" do
          expect(page).to have_content("Joined: #{@user_2.created_at}")
        end

        within ".default-user-#{@user_3.id}" do
          expect(page).to have_content("Joined: #{@user_3.created_at}")
        end

        within ".default-user-#{@user_4.id}" do
          expect(page).to have_content("Joined: #{@user_4.created_at}")
        end
      end
    end

    it "I see an 'Upgrade to Merchant' button beside each user name" do
      visit admin_users_path

      within ".all-default-users" do
        within ".default-user-#{@user_1.id}" do
          expect(page).to have_button("Upgrade to Merchant")
        end

        within ".default-user-#{@user_2.id}" do
          expect(page).to have_button("Upgrade to Merchant")
        end

        within ".default-user-#{@user_3.id}" do
          expect(page).to have_button("Upgrade to Merchant")
        end

        within ".default-user-#{@user_4.id}" do
          expect(page).to have_button("Upgrade to Merchant")
        end
      end
    end

    describe "and click 'Upgrade to Merchant'" do
      it "the user is upgraded to a merchant" do
        visit admin_users_path

        within ".default-user-#{@user_1.id}" do
          click_button "Upgrade to Merchant"
        end

        expect(current_path).to eq(merchant_path(@user_1))

        @user_1.reload

        expect(@user_1.role).to eq("merchant")
      end
    end
  end
end
