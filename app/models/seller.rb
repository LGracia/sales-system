# frozen_string_literal: true

# Seller
class Seller < ApplicationRecord
  validates_presence_of :name, :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
