class GrowingUser < ApplicationRecord
  validates_uniqueness_of :mobile
end
