require "rails_helper"

describe Cart do

  it ".quantity" do
    cart = Cart.new({'1' => 3, '2' => 5, '3' => 1})
    expect(cart.quantity).to eq(9)
  end

  it ".add" do
    cart = Cart.new({'1' => 3, '2' => 5, '3' => 1})
    cart.add('4', 9)

    expect(cart.contents).to eq({'1' => 3, '2' => 5, '3' => 1, '4' => 9})

    cart.add('1', 0)

    expect(cart.contents['1']).to be_nil
  end

  it ".quantity_of" do
    cart = Cart.new({'1' => 3, '2' => 5, '3' => 1})
    expect(cart.quantity_of('2')).to eq(5)
  end

  it ".items" do
    user = User.create!(email: "user_1@gmail.com", role: 2, name: "User 1", address: "User 1 Address", city: "User 1 City", state: "User 1 State",zip:"12345", password: "123456")
    a = user.items.create!(name: "1", active: true, price: 1.00, description: "Item 1 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 10)
    b = user.items.create!(name: "2", active: true, price: 2.00, description: "Item 2 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 15)
    c = user.items.create!(name: "3", active: true, price: 3.00, description: "Item 3 Description", image: "https://tradersofafrica.com/img/noproductphoto.jpg", inventory: 20)
    cart = Cart.new({a.id => 3, b.id => 5, c.id => 1})
    expect(cart.items).to eq({a => 3, b => 5, c => 1})
  end
end
