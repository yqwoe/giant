class Shop < ApplicationRecord
  has_many :deals
  has_many :suites
  has_many :comments, as: :commentable, through: :deals

  belongs_to :user

  enum status: [:inactived, :actived]
end
