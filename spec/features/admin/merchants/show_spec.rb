require 'rails_helper'

RSpec.describe "when I visit a merchant's show page" do
  describe "as an admin" do
    before :each do
      @admin = User.create!(email: "admin@gmail.com", role: 2, active: true, name: "Admin", address: "Admin Address", city: "Admin City", state: "Admin State", zip: "12345", password: "123456")
      @merchant = User.create!(email: "merchant@gmail.com", role: 1, active: true, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "22345", password: "123456")
      @user = User.create!(email: "user@gmail.com", role: 0, active: true, name: "User", address: "User Address", city: "User City", state: "User State", zip: "52345", password: "123456")

      @item = @merchant.items.create!(name: "Item", active: true, price: 1.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @order = @user.orders.create!(status: 3)
      @order_item = @order.order_items.create!(item_id: @item.id, quantity: 1, price: 1.00, fulfilled: true)

      visit root_path

      click_on "LogIn"
      fill_in "email", with: @admin.email
      fill_in "password", with: @admin.password
      click_on "Log In"
    end

    it "I see all the same information that merchant would see" do
      visit admin_merchant_path(@merchant)

      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@merchant.email)
      expect(page).to have_content(@merchant.address)
      expect(page).to have_content(@merchant.city)
      expect(page).to have_content(@merchant.state)
      expect(page).to have_content(@merchant.zip)

      within "#item-#{@item.id}" do
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item.inventory)
        expect(page).to have_content("Edit")
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Enable")
        expect(page).to have_content("Delete")
      end
    end

    it "the page displays a button to downgrade the merchant's account to a user account" do
      visit admin_merchant_path(@merchant)

      expect(page).to have_button("Downgrade to User")
    end

    describe "and click the 'Downgrade to User' button" do
      it "I am redirected to that merchant's user profile" do
        visit admin_merchant_path(@merchant)

        click_button "Downgrade to User"

        expect(current_path).to eq(admin_user_path(@merchant))
      end

      it "I see a flash message indicated that the user has been upgraded" do
        visit admin_merchant_path(@merchant)

        click_button "Downgrade to User"

        expect(page).to have_content("#{@merchant.name} has been downgraded to a User.")
      end

      it "the user becomes a merchant" do
        visit admin_merchant_path(@merchant)

        click_button "Downgrade to User"

        @merchant.reload

        expect(@merchant.role).to eq("default")
      end
    # end
    #
    # context "as a visitor" do
    #   it "I recieve a 404 error" do
    #     click_link "Logout"
    #
    #     visit admin_merchant_path(@merchant)
    #
    #     expect(page.status_code).to eq(404)
    #     expect(page).to have_content("The page you were looking for doesn't exist.")
    #   end
    # end
    #
    # context "as a user" do
    #   it "I recieve a 404 error" do
    #     click_link "Logout"
    #
    #     visit root_path
    #
    #     click_on "LogIn"
    #     fill_in "email", with: @user.email
    #     fill_in "password", with: @user.password
    #     click_on "Log In"
    #
    #     visit admin_merchant_path(@merchant)
    #
    #     expect(page.status_code).to eq(404)
    #     expect(page).to have_content("The page you were looking for doesn't exist.")
    #   end
    # end
    #
    # context "as a merchant" do
    #   it "I recieve a 404 error" do
    #     click_link "Logout"
    #
    #     visit root_path
    #
    #     click_on "LogIn"
    #     fill_in "email", with: @merchant.email
    #     fill_in "password", with: @merchant.password
    #     click_on "Log In"
    #
    #     visit admin_merchant_path(@merchant)
    #
    #     expect(page.status_code).to eq(404)
    #     expect(page).to have_content("The page you were looking for doesn't exist.")
    #   end
    end
  end
end
