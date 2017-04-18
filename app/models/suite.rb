class Suite < ApplicationRecord
  has_many :wares
  enum tags: [:hot]
end
