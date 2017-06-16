class Shop < ApplicationRecord
  acts_as_paranoid
  acts_as_geolocated lat: 'cast(position[1] as real)', lng: 'cast(position[2] as real)'

  has_many :deals
  has_many :suites
  has_many :comments, as: :commentable, through: :deals

  belongs_to :user

  enum status: [:inactived, :actived, :pending]

end
