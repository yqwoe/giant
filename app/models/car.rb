class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :user
  has_many :deals
  has_many :violations
  has_many :cards

  enum status: [:trial, :annual]

end
