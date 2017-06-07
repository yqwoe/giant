class Shop < ApplicationRecord
  acts_as_paranoid

  has_many :deals
  has_many :suites
  has_many :comments, as: :commentable, through: :deals

  belongs_to :user

  enum status: [:inactived, :actived, :deleted, :pending]
end
