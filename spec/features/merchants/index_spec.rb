RSpec.describe 'As a visitor' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  describe "when I visit the merchant's index page" do
    it 'I see all merchants names with city, state, and date they registered' do
      visit merchants_path

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_1.city)
        expect(page).to have_content(@merchant_1.state)
        expect(page).to have_content(Date.strptime(@merchant_1.created_at.to_s))
      end

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_2.city)
        expect(page).to have_content(@merchant_2.state)
        expect(page).to have_content(Date.strptime(@merchant_2.created_at.to_s))
      end

      within "#merchant-#{@merchant_3.id}" do
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_3.city)
        expect(page).to have_content(@merchant_3.state)
        expect(page).to have_content(Date.strptime(@merchant_3.created_at.to_s))
      end
    end

    it 'I see merchant statistics' do
      

    end

  end

  # USER STORY 40
  # As a visitor
  # When I visit the merchants index page, I see an area with statistics:
  # - top 3 merchants who have sold the most by price and quantity, and their revenue
  # - top 3 merchants who were fastest at fulfilling items in an order, and their times
  # - worst 3 merchants who were slowest at fulfilling items in an order, and their times
  # - top 3 states where any orders were shipped (by number of orders), and count of orders
  # - top 3 cities where any orders were shipped (by number of orders, also Springfield, MI should not be grouped with Springfield, CO), and the count of orders
  # - top 3 biggest orders by quantity of items shipped in an order, plus their quantities

end
