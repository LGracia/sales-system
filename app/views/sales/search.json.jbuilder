# frozen_string_literal: true

# json.array! @orders do |order|
#   json.merge! order['attributes']
# end

json.orders @orders do |order|
  json.id order.id
  json.seller do
    json.id order.seller.name
    json.name order.seller.name
    json.email order.seller.email
  end
  json.customer do
    json.id order.customer.name
    json.name order.customer.name
    json.email order.customer.email
  end
  json.city order.city.name
  json.state order.state.name
  json.products order.products do |product|
    json.name product.name
    json.code product.code
  end
  json.created_at order.created_at
end

json.page @page
json.per_page @per_page
