require 'rails_helper'
describe "as a merchant" do
  describe "when I visit my dashboard page" do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @user1 = create(:user)

      @item1 = create(:item, user: @merchant1)
      @item2 = create(:item, user: @merchant1)
      @item3 = create(:item, user: @merchant1)
      @item4 = create(:item, user: @merchant2)

      @order1 = create(:pending, user: @user1)
      @order2 = create(:pending, user: @user1)
      @order3 = create(:pending, user: @user1)
      @order4 = create(:packaged, user: @user1)

      @order_item1 = create(:order_item, order: @order1, item: @item1)
      @order_item2 = create(:order_item, order: @order1, item: @item2)
      @order_item3 = create(:order_item, order: @order2, item: @item2)
      @order_item4 = create(:order_item, order: @order2, item: @item3)
      @order_item5 = create(:order_item, order: @order2, item: @item4)
      @order_item6 = create(:order_item, order: @order3, item: @item4)
      @order_item7 = create(:order_item, order: @order4, item: @item1)
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

    it "displays a list of pending orders that contain merchant items" do
      visit root_path
      click_link "LogIn"
      fill_in 'email', with: @merchant1.email
      fill_in 'password', with: @merchant1.password
      click_button "Log In"

      expect(page).to have_content(@order1.id)
      #the ID of the order, which is a link to the order show page ("/dashboard/orders/15")
      # expect(page).to have_link(@order1.id) # might need to hard code this link in here, might be @order1 without id
      expect(page).to have_content(@order1.created_at.to_formatted_s(:long).slice(0...-6))
      expect(page).to have_content(@order1.total_item_count)
      expect(page).to have_content('%.2f' % @order1.total_price)
    end
  end
end
