# frozen_string_literal: true

# Order
class Order < ApplicationRecord
  belongs_to :seller
  belongs_to :customer
  belongs_to :city
  belongs_to :state
  has_many :order_details
  has_many :products, through: :order_details
end
