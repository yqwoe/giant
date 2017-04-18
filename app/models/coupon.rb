class Coupon < ApplicationRecord
  enum status: [:unused, :used, :expired]
end
