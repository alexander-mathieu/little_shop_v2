require "rails_helper"

describe Cart do

  it ".contents" do
    cart = Cart.new({1 => 3, 2 => 5, 3 => 1})
    expect(cart.quantity).to eq(9)
  end
end
