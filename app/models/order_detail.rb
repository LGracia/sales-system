# frozen_string_literal: true

# OrderDetail
class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
end
