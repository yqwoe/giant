class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment

  enum status: [:uncommented, :commented]

  include Queriable
end
