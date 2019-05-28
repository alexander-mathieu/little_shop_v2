require 'rails_helper'

RSpec.describe "when I visit a merchant's show page" do
  describe "as an admin" do
    before :each do
      @admin = User.create!(email: "admin@gmail.com", role: 2, active: true, name: "Admin", address: "Admin Address", city: "Admin City", state: "Admin State", zip: "12345", password: "123456")
      @merchant = User.create!(email: "merchant@gmail.com", role: 1, active: true, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "22345", password: "123456")
      @user = User.create!(email: "user@gmail.com", role: 0, active: true, name: "User", address: "User Address", city: "User City", state: "User State", zip: "52345", password: "123456")

      @item_1 = @merchant.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @merchant.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @merchant.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)
      @item_4 = @merchant.items.create!(name: "Item 4", active: true, price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 25)

      @order = @user.orders.create!(status: 3)
      @order_item = @order.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: true)

      visit root_path

      click_on "Login"
      fill_in "email", with: @admin.email
      fill_in "password", with: @admin.password
      click_on "Log In"
    end

    it "I see all the same information that merchant would see" do
      visit merchant_path(@merchant)

      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@merchant.email)
      expect(page).to have_content(@merchant.address)
      expect(page).to have_content(@merchant.city)
      expect(page).to have_content(@merchant.state)
      expect(page).to have_content(@merchant.zip)

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content("Edit")
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Enable")
        expect(page).to have_content("Delete")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.inventory)
        expect(page).to have_content("Edit")
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Enable")
        expect(page).to have_content("Delete")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_3.inventory)
        expect(page).to have_content("Edit")
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Enable")
        expect(page).to have_content("Delete")
      end

      within "#item-#{@item_4.id}" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_4.inventory)
        expect(page).to have_content("Edit")
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Enable")
        expect(page).to have_content("Delete")
      end
    end

    it "the page displays a button to downgrade the merchant's account to a user account" do
      visit merchant_path(@merchant)

      expect(page).to have_button("Downgrade to User")
    end

    describe "and click the 'Downgrade to User' button" do
      it "I am redirected to that merchant's user profile" do
        visit merchant_path(@merchant)

        click_button "Downgrade to User"

        expect(current_path).to eq(admin_user_path(@merchant))
      end

      it "I see a flash message indicated that the user has been upgraded" do
        visit merchant_path(@merchant)

        click_button "Downgrade to User"

        expect(page).to have_content("#{@merchant.name} has been downgraded to a User.")
      end

      it "the user becomes a merchant" do
        visit merchant_path(@merchant)

        click_button "Downgrade to User"

        @merchant.reload

        expect(@merchant.role).to eq("default")
      end

      it "all of the merchant's items are disabled" do
        visit merchant_path(@merchant)

        click_button "Downgrade to User"

        @item_1.reload
        @item_2.reload
        @item_3.reload
        @item_4.reload

        expect(@item_1.active).to eq(false)
        expect(@item_2.active).to eq(false)
        expect(@item_3.active).to eq(false)
        expect(@item_4.active).to eq(false)
      end

      describe "and that merchant is a user" do
        it "I'm redirected to that user's show page" do
          visit merchant_path(@user)

          expect(current_path).to eq(merchant_path(@user))
        end
      end
    end

    context "as a visitor" do
      it "I do not see the 'Downgrade to User' button" do
        click_link "Logout"

        visit merchant_path(@merchant)

        expect(page).to_not have_content("Downgrade to User")
      end
    end

    context "as a user" do
      it "I do not see the 'Downgrade to User' button" do
        click_link "Logout"

        visit root_path

        click_on "Login"
        fill_in "email", with: @user.email
        fill_in "password", with: @user.password
        click_on "Log In"

        visit merchant_path(@merchant)

        expect(page).to_not have_content("Downgrade to User")
      end
    end

    context "as a merchant" do
      it "I do not see the 'Downgrade to User' button" do
        click_link "Logout"

        visit root_path

        click_on "Login"
        fill_in "email", with: @merchant.email
        fill_in "password", with: @merchant.password
        click_on "Log In"

        visit merchant_path(@merchant)

        expect(page).to_not have_content("Downgrade to User")
      end
    end
  end
end
