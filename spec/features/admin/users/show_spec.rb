require 'rails_helper'

RSpec.describe "when I visit a user's show page" do
  describe "as an admin" do
    before :each do
      @admin = User.create!(email: "admin@gmail.com", role: 2, name: "Admin", address: "Admin Address", city: "Admin City", state: "Admin State", zip: "12345", password: "123456")
      @merchant = User.create!(email: "merchant@gmail.com", role: 1, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "22345", password: "123456")
      @user = User.create!(email: "user@gmail.com", role: 0, name: "User", address: "User Address", city: "User City", state: "User State", zip: "52345", password: "123456")

      @item = @user.items.create!(name: "Item", active: true, price: 1.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @order = @user.orders.create!(status: 3)
      @order_item = @order.order_items.create!(item_id: @item.id, quantity: 1, price: 1.00, fulfilled: true)

      visit root_path

      click_on "LogIn"
      fill_in "email", with: @admin.email
      fill_in "password", with: @admin.password
      click_on "Log In"
    end

    it "I see all the same information that user would see" do
      visit admin_user_path(@user)

      within ".user-profile-#{@user.id}" do
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.address)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.zip)
      end
    end

    it "I do not see a link to edit the user's profile" do
      visit admin_user_path(@user)

      within ".user-profile-#{@user.id}" do
        expect(page).to_not have_link("Edit My Profile")
      end
    end

    it "I see a link to view the user's orders, unless the user has no orders" do
      no_order_user = User.create!(email: "no_order_user@gmail.com", role: 2, name: "No Order User", address: "No Order User Address", city: "No Order User City", state: "No Order User State", zip: "12345", password: "123456")

      visit admin_user_path(@user)

      within ".user-profile-#{@user.id}" do
        expect(page).to have_link("View Orders")

        click_link "View Orders"

        expect(current_path).to eq(admin_user_orders_path(@user))
      end

      visit admin_user_path(no_order_user)

      within ".user-profile-#{no_order_user.id}" do
        expect(page).to_not have_link("View Orders")
      end
    end

    it "the page displays a button to upgrade the user's account to a merchant account" do
      visit admin_user_path(@user)

      expect(page).to have_button("Upgrade to Merchant")
    end

    # describe "and click the 'Upgrade to Merchant' button" do
    #   it "I am redirected to that user's new merchant dashboard"
    #   it "I see a flash message indicated that the user has been upgraded"
    # end

    # The next time this user logs in they are now a merchant

    context "as a visitor" do
      it "I recieve a 404 error" do
        click_link "Logout"

        visit admin_user_path(@user)

        expect(page.status_code).to eq(404)
        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end

    context "as a user" do
      it "I recieve a 404 error" do
        click_link "Logout"

        visit root_path

        click_on "LogIn"
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_on "Log In"

        visit admin_user_path(@user)

        expect(page.status_code).to eq(404)
        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end

    context "as a merchant" do
      it "I recieve a 404 error" do
        click_link "Logout"

        visit root_path

        click_on "LogIn"
        fill_in "email", with: @merchant.email
        fill_in "password", with: @merchant.password
        click_on "Log In"

        visit admin_user_path(@user)

        expect(page.status_code).to eq(404)
        expect(page).to have_content("The page you were looking for doesn't exist.")
      end
    end
  end
end
