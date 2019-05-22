require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it {should have_many(:items)}
    it {should have_many :orders}
  end

  describe "class methods" do
    before :each do
      @user_1 = create(:merchant)
      @user_2 = create(:user)
      @user_3 = create(:merchant)

      @users = User.all
    end
    it ".find_merchants" do
      expect(@users.find_merchants).to eq([@user_1, @user_3])
    end
  end
end
