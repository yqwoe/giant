class Shop < ApplicationRecord
  has_many :deals
  has_many :wares
  has_many :comments

  belongs_to :user

  enum status: [:inactived, :actived]
end
