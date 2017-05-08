class Suite < ApplicationRecord
  belongs_to :shop
  has_many :wares
  enum tags: [:hot]
end
