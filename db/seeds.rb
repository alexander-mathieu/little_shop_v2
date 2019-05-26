# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Order.destroy_all
OrderItem.destroy_all
Item.destroy_all
User.destroy_all

admin_1 = User.create!(email: "megan@littleshop.com", password: "password", role: 2, active: true, name: "Megan", address: "1234 Zebra St", city: "Denver", state: "CO", zip: '90210')
admin_2 = User.create!(email: "brian@littleshop.com", password: "password", role: 2, active: true, name: "Brian", address: "1234 Wahoo Way", city: "Denver", state: "CO", zip: '90210')

merchant_1 = User.create!(email: "alex@gmail.com", password: "password", role: 1, active: true, name: "Alex", address: "1234 Protein Pl", city: "Burlington", state: "VT", zip: '64086')
merchant_2 = User.create!(email: "aurie@gmail.com", password: "password", role: 1, active: true, name: "Aurie", address: "1234 Codeislife Ct", city: "Boulder", state: "CO", zip: '64086')
merchant_3 = User.create!(email: "kyle@gmail.com", password: "password", role: 1, active: true, name: "Kyle", address: "1234 Roadrunner Rd", city: "Springfield", state: "VA", zip: '64086')
merchant_4 = User.create!(email: "patrick@gmail.com", password: "password", role: 1, active: true, name: "Patrick", address: "1234 Boilermaker Blvd", city: "West Lafayette", state: "IN", zip: '64086')

buyer_1 = User.create!(email: 'buyer1@gmail.com', password: 'password', active: true, name: 'Buyer 1', address: '1234 Test Dr', city: 'Denver', state: 'CO', zip: '80123')
buyer_2 = User.create!(email: 'buyer2@gmail.com', password: 'password', active: true, name: 'Buyer 2', address: '1234 Test Dr', city: 'Denver', state: 'CO', zip: '80123')
buyer_3 = User.create!(email: 'buyer3@gmail.com', password: 'password', active: true, name: 'Buyer 3', address: '1234 Test Dr', city: 'Denver', state: 'CO', zip: '80123')
buyer_4 = User.create!(email: 'buyer4@gmail.com', password: 'password', active: true, name: 'Buyer 4', address: '1234 Test Dr', city: 'Denver', state: 'CO', zip: '80123')
buyer_5 = User.create!(email: 'buyer5@gmail.com', password: 'password', active: true, name: 'Buyer 5', address: '1234 Test Dr', city: 'Denver', state: 'CO', zip: '80123')

item_1 = Item.create!(name: 'Mike Trout', active: true, price: 11.00, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51GOReQ-ckL.jpg', inventory: 168, user: merchant_1)
item_2 = Item.create!(name: 'Max Scherzer', active: true, price: 12.50, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51Q%2Bv6TFHZL.jpg', inventory: 140, user: merchant_3)
item_3 = Item.create!(name: 'Clayton Kershaw', active: true, price: 13.00, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51sOKiT8jwL._SY445_.jpg', inventory: 160, user: merchant_2)
item_4 = Item.create!(name: 'Nolan Arenado', active: true, price: 14.44, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/41zv0W8xOsL.jpg', inventory: 150, user: merchant_4)
item_5 = Item.create!(name: 'Derek Jeter', active: true, price: 18.46, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/61y8sAnxTML._SY606_.jpg', inventory: 130, user: merchant_1)
item_6 = Item.create!(name: 'Tony Gwynn', active: true, price: 21.00, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/5107DHIW6OL._SY445_.jpg', inventory: 60, user: merchant_2)
item_7 = Item.create!(name: 'Ken Griffey', active: true, price: 23.05, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51JtJOXCAnL.jpg', inventory: 24, user: merchant_4)
item_8 = Item.create!(name: 'Cal Ripken', active: true, price: 28.08, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51h0J4aUSoL._SY445_.jpg', inventory: 88, user: merchant_3)
item_9 = Item.create!(name: 'Nolan Ryan', active: true, price: 38.30, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51Mxd3NY6tL.jpg', inventory: 33, user: merchant_1)
item_10 = Item.create!(name: 'Jackie Robinson', active: true, price: 42.00, description: 'item_description', image: 'https://i.ebayimg.com/images/g/CDsAAOSwJo5a-Otk/s-l640.jpg', inventory: 42, user: merchant_2)
item_11 = Item.create!(name: 'Willie Mays', active: true, price: 47.80, description: 'item_description', image: 'http://www.vintagecardprices.com/pics/68802.jpg', inventory: 9, user: merchant_3)
item_12 = Item.create!(name: 'Shoeless Joe Jackson', active: true, price: 64.22, description: 'item_description', image: 'https://www.gfg.com/baseball/jjlarge.jpg', inventory: 12, user: merchant_4)
item_13 = Item.create!(name: 'Hank Aaron', active: true, price: 66.71, description: 'item_description', image: 'https://i.ebayimg.com/images/g/FNwAAOSwAaJaHxUc/s-l640.jpg', inventory: 4, user: merchant_1)
item_14 = Item.create!(name: 'Babe Ruth', active: true, price: 71.70, description: 'item_description', image: 'http://content.propertyroom.com/listings/sellers/seller600044/images/homeimgs/600044_1562018161712114.jpg', inventory: 3, user: merchant_2)
item_15 = Item.create!(name: 'Mickey Mantle', active: true, price: 113.00, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51CHfNJEAkL._SY445_.jpg', inventory: 5, user: merchant_3)
item_16 = Item.create!(name: 'Honus Wagner', active: true, price: 312.00, description: 'item_description', image: 'https://images-na.ssl-images-amazon.com/images/I/51SU9b9GoCL._SY445_.jpg', inventory: 1, user: merchant_4)

order_1 = Order.create!(user: buyer_1, status: 0)
order_2 = Order.create!(user: buyer_2, status: 1)
order_3 = Order.create!(user: buyer_3, status: 2)
order_4 = Order.create!(user: buyer_4, status: 3)
order_5 = Order.create!(user: buyer_5, status: 0)
order_6 = Order.create!(user: buyer_1, status: 1)
order_7 = Order.create!(user: buyer_2, status: 2)

order_item_1 = OrderItem.create!(item: item_2, order: order_1, quantity: 12, price: item_2.price, fulfilled: true)
order_item_2 = OrderItem.create!(item: item_3, order: order_2, quantity: 2, price: item_3.price, fulfilled: true)
order_item_3 = OrderItem.create!(item: item_1, order: order_3, quantity: 3, price: item_1.price, fulfilled: true)
order_item_4 = OrderItem.create!(item: item_4, order: order_4, quantity: 4, price: item_4.price, fulfilled: true)
order_item_5 = OrderItem.create!(item: item_15, order: order_5, quantity: 5, price: item_15.price, fulfilled: true)
order_item_6 = OrderItem.create!(item: item_5, order: order_6, quantity: 6, price: item_5.price, fulfilled: true)
order_item_7 = OrderItem.create!(item: item_6, order: order_7, quantity: 2, price: item_6.price, fulfilled: true)
order_item_8 = OrderItem.create!(item: item_7, order: order_1, quantity: 3, price: item_7.price, fulfilled: true)
order_item_9 = OrderItem.create!(item: item_8, order: order_2, quantity: 4, price: item_8.price, fulfilled: true)
order_item_10 = OrderItem.create!(item: item_9, order: order_3, quantity: 9, price: item_9.price, fulfilled: true)
order_item_11 = OrderItem.create!(item: item_14, order: order_4, quantity: 1, price: item_14.price, fulfilled: true)
order_item_12 = OrderItem.create!(item: item_13, order: order_5, quantity: 2, price: item_13.price, fulfilled: true)
order_item_13 = OrderItem.create!(item: item_12, order: order_6, quantity: 3, price: item_12.price, fulfilled: true)
order_item_14 = OrderItem.create!(item: item_11, order: order_7, quantity: 4, price: item_11.price, fulfilled: true)
order_item_15 = OrderItem.create!(item: item_10, order: order_1, quantity: 9, price: item_10.price, fulfilled: true)
order_item_16 = OrderItem.create!(item: item_2, order: order_2, quantity: 21, price: item_2.price, fulfilled: true)
order_item_17 = OrderItem.create!(item: item_3, order: order_3, quantity: 4, price: item_3.price, fulfilled: true)
order_item_18 = OrderItem.create!(item: item_1, order: order_4, quantity: 1, price: item_1.price, fulfilled: true)
order_item_19 = OrderItem.create!(item: item_4, order: order_5, quantity: 2, price: item_4.price, fulfilled: true)
order_item_20 = OrderItem.create!(item: item_5, order: order_6, quantity: 87, price: item_5.price, fulfilled: true)
order_item_21 = OrderItem.create!(item: item_6, order: order_7, quantity: 23, price: item_6.price, fulfilled: true)
order_item_22 = OrderItem.create!(item: item_7, order: order_1, quantity: 1, price: item_7.price, fulfilled: true)
order_item_23 = OrderItem.create!(item: item_8, order: order_2, quantity: 6, price: item_8.price, fulfilled: true)
order_item_24 = OrderItem.create!(item: item_9, order: order_3, quantity: 3, price: item_9.price, fulfilled: true)
order_item_25 = OrderItem.create!(item: item_16, order: order_4, quantity: 1, price: item_16.price, fulfilled: true)
