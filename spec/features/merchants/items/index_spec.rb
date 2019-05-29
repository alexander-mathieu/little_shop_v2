require 'rails_helper'

RSpec.describe "as a merchant" do
  describe "when I visit my item index page" do
    before :each do
      @merchant = User.create!(email: "merchant@gmail.com", role: 1, active: true, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "22345", password: "123456")

      @item_1 = @merchant.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @merchant.items.create!(name: "Item 2", active: false, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 15)
      @item_3 = @merchant.items.create!(name: "Item 3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 20)
      @item_4 = @merchant.items.create!(name: "Item 4", active: true, price: 4.00, description: "Item 4 Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 25)

      visit root_path

      click_link "Login"

      fill_in 'email', with: @merchant.email
      fill_in 'password', with: @merchant.password

      click_button "Log In"

      click_link "Dashboard"

      click_link "View All Items"
    end

    it "it displays all my items" do
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
        expect(page).to_not have_content("Disable")
        expect(page).to have_content("Enable")
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

    it "I can edit an item" do
      within "#item-#{@item_1.id}" do
        click_on "Edit"
      end

      expect(current_path).to eq(edit_item_path(@item_1))

      fill_in "item[name]", with: "Updated Item 1"

      click_on "Update Item"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Item updated.")

      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Updated Item 1")
      end
    end

    it "I can enable/disable items" do
      within "#item-#{@item_1.id}" do
        click_on "Disable"
      end

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Item has been disabled.")

      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Enable")
        expect(page).to_not have_content("Disable")
      end

      within "#item-#{@item_1.id}" do
        click_on "Enable"
      end

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Item has been enabled.")

      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Disable")
        expect(page).to_not have_content("Enable")
      end
    end

    it "I can delete an item" do
      within "#item-#{@item_1.id}" do
        click_on "Delete"
      end

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Item has been deleted.")

      expect(page).to_not have_content(@item_1.name)
    end
  end
end
