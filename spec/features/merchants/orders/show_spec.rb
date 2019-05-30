require "rails_helper"

describe "as a merchant" do
  describe "when I visit an order show from my dashboard" do
    before :each do

      @merchant_1 = User.create!(email: "merchant@gmail.com", role: 1, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "22345", password: "123456")
      @merchant_2 = User.create!(email: "merchant_2@gmail.com", role: 1, name: "Merchant", address: "Merchant Address", city: "Merchant City", state: "Merchant State", zip: "22345", password: "123456")
      @user = User.create!(email: "user@gmail.com", role: 0, name: "User", address: "User Address", city: "User City", state: "User State", zip: "52345", password: "123456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 1)
      @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 1.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_4 = @merchant_2.items.create!(name: "Item 4", active: true, price: 1.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 10)
      @item_5 = @merchant_1.items.create!(name: "Item 5", active: true, price: 2.00, description: "Item Description", image: "https://tradersofafrica.com/img/no-product-photo.jpg", inventory: 1)

      @order_1 = @user.orders.create!(status: 0)
      @order_2 = @user.orders.create!(status: 0)

      @order_item_1 = @order_1.order_items.create!(item_id: @item_1.id, quantity: 1, price: 1.00, fulfilled: false)
      @order_item_2 = @order_1.order_items.create!(item_id: @item_2.id, quantity: 3, price: 6.00, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item_id: @item_4.id, quantity: 6, price: 1.00, fulfilled: true)
      @order_item_4 = @order_1.order_items.create!(item_id: @item_5.id, quantity: 3, price: 6.00, fulfilled: false)

      @order_3 = @user.orders.create!(status: 0)
      @order_item_5 = @order_3.order_items.create!(item_id: @item_2.id, quantity: 1, price: 6.00, fulfilled: false)
      @order_item_7 = @order_3.order_items.create!(item_id: @item_3.id, quantity: 2, price: 6.00, fulfilled: false)
      @order_item_6 = @order_3.order_items.create!(item_id: @item_4.id, quantity: 6, price: 1.00, fulfilled: false)




      visit root_path

      click_on "Login"
      fill_in "email", with: @merchant_1.email
      fill_in "password", with: @merchant_1.password
      click_on "Log In"
      visit "/dashboard/orders/#{@order_1.id}"
    end
    #Be Aware of How Price works on items vs order_items
    it "shows me order information" do
      visit "/dashboard/orders/#{@order_1.id}"
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.address)
      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
        find "img[src='#{@item_1.image}']"
        expect(page).to have_content("Price: #{@item_1.price}")
        expect(page).to have_content("Quantity: #{@order_item_1.quantity}")
      end
      within "#item-#{@item_2.id}" do
        expect(page).to have_link(@item_2.name)
        find "img[src='#{@item_2.image}']"
        expect(page).to have_content("Price: #{@item_2.price}")
        expect(page).to have_content("Quantity: #{@order_item_2.quantity}")
      end
      expect(page).to_not have_css"#item-#{@item_3.id}"
      expect(page).to_not have_css"#item-#{@item_4.id}"
    end

    it "shows me a fulfill button If i have inventory && item not fulfilled" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_button("Fulfill Order")
      end
      within "#item-#{@item_2.id}" do
        expect(page).to_not have_button("Fulfill Order")
      end
      within "#item-#{@item_5.id}" do
        expect(page).to_not have_button("Fulfill Order")
      end

    end



    it "the fulfill button fulfills the order" do

      within "#item-#{@item_1.id}" do
        click_button("Fulfill Order")
      end
        expect(current_path).to eq(merchant_order_path(@order_1))
        expect(page).to have_content("Fulfilled item #{@item_1.name} of this order")
        @order_item_1.reload
        expect(@order_item_1.fulfilled).to eq(true)
        @item_1.reload
        expect(@item_1.inventory).to eq(9)
        within "#item-#{@item_1.id}" do
          expect(page).to have_content("Order Fulfilled")
        end
    end

    it "Says Insufficient inventory If I cant fulfill and order" do
      within "#item-#{@item_5.id}" do
        expect(page).to have_css('h2', :text => 'Insufficient Inventory')
      end

      within "#item-#{@item_1.id}" do
        expect(page).to_not have_css('h2', :text => 'Insufficient Inventory')
      end

      within "#item-#{@item_2.id}" do
        expect(page).to_not have_css('h2', :text => 'Insufficient Inventory')
      end
    end

    it "fulfilling all order_items in an order changes its status to packaged" do
      visit "/dashboard/orders/#{@order_3.id}"

      within "#item-#{@item_2.id}" do
        click_button("Fulfill Order")
      end
      @order_3.reload
      expect(@order_3.packaged?).to eq(false)
      expect(@order_3.pending?).to eq(true)
      within "#item-#{@item_3.id}" do
        click_button("Fulfill Order")
      end
      click_link("Logout")
      @order_3.reload
      expect(@order_3.packaged?).to eq(false)
      expect(@order_3.pending?).to eq(true)
      click_on "Login"
      fill_in "email", with: @merchant_2.email
      fill_in "password", with: @merchant_2.password
      click_on "Log In"
      visit "/dashboard/orders/#{@order_3.id}"
      within "#item-#{@item_4.id}" do
        click_button("Fulfill Order")
      end
      @order_3.reload
      expect(@order_3.packaged?).to eq(true)
      expect(@order_3.pending?).to eq(false)

    end

  end
end
