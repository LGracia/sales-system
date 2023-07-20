# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

cities = []

10.times do |_|
  city_name = Faker::Address.unique.city

  cities << { name: city_name }
end

City.insert_all(cities)

cities = City.all

cities.each do |city|
  (1..3).map{ |n| State.create(name: Faker::Address.unique.state, city: city) }
end

sellers = []

100.times do |_|
  seller_name = Faker::Name.unique.name
  sellers << { name: seller_name, email: Faker::Internet.email(name: seller_name) }
end

Seller.insert_all(sellers)

customers = []

100.times do |_|
  customer_name = Faker::Name.unique.name
  customers << { name: customer_name, email: Faker::Internet.email(name: customer_name) }
end

Customer.insert_all(customers)

products = []

1_000.times do |_|
  products << { 
    name: Faker::Commerce.unique.product_name,
    code: Faker::Alphanumeric.unique.alphanumeric(number: 10),
    cost: Faker::Commerce.price(range: 4.01..100.99, as_string: false)
  }
end

Product.insert_all(products)

sellers = Seller.all
customers = Customer.all
products = Product.all

10_100.times do |_|
  city = cities.sample
  number_of_products = (1..15).to_a
  order_details =
    products.sample(number_of_products.sample).map do |product|
      quantity = number_of_products.sample
      unit_cost = product.cost
      total_cost = quantity * unit_cost
      total_seller_price = (total_cost.to_i..total_cost.to_i + 70).to_a.sample

      OrderDetail.new(
        product: product,
        unit_cost: unit_cost,
        quantity: quantity,
        total_cost: total_cost,
        total_seller_price: total_seller_price
      )
    end

  Order.create({
    seller_id: sellers.sample.id,
    customer_id: customers.sample.id,
    city_id: city.id,
    state_id: city.states.sample.id,
    order_details: order_details
  })
end
