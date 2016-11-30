class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :user
  has_many :deals

  enum status: [:trial, :annual]

end
