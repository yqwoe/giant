class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
end