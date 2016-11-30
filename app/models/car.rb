class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :user

  has_many :deals, as: :dealsable

  enum status: [:trial, :annual]


end
