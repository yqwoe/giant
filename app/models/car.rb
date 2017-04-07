class Car < ApplicationRecord
  before_save :upcase_licensed_id
 
  belongs_to :car_model
  belongs_to :user

  has_many :deals
  has_many :violations
  has_many :cards
  has_many :orders

  enum status: [:trial, :annual]

  private

  def upcase_licensed_id
    licensed_id.upcase!
  end
end
