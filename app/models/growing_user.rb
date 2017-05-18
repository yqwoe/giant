class GrowingUser < ApplicationRecord
  validates_uniqueness_of :mobile
  enum status: [:unenrolled, :enrolled, :enrolled_520]

  has_one :card
end
