class GrowingCard < ApplicationRecord
  validates_uniqueness_of :cid, :pin
end
