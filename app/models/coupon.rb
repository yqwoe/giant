class Coupon < ApplicationRecord
  enum status: [:unused, :used, :expired]
  has_many :suite_orders
end
