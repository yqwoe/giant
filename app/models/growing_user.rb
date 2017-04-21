class GrowingUser < ApplicationRecord
  validates_uniqueness_of :mobile
  enum status: [:unenrolled, :enrolled]

  has_one :card
end
