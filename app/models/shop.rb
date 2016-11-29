class Shop < ApplicationRecord
  has_many :deals, as: :dealsable
end
