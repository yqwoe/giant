class Shop < ApplicationRecord
  has_many :deals

  belongs_to :user
end
