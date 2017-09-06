class Shop < ApplicationRecord
  acts_as_paranoid
  acts_as_geolocated

  has_many :deals
  has_many :suites
  has_many :comments, as: :commentable, through: :deals

  belongs_to :user

  enum status: [:inactived, :actived, :pending]

  scope :luoyang, -> { where "city = 洛阳市" }


end
