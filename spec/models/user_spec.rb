require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it {should have_many :orders}
    it {should have_many(:order_items).through(:orders)}
    it {should have_many(:items).through(:order_items)}
  end
end
