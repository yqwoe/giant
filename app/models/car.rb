class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :user

  enum status: [:trial, :annual]


end
