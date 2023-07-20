# frozen_string_literal: true

# City
class City < ApplicationRecord
  has_many :states
end
