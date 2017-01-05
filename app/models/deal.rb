class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
  belongs_to :user
end
