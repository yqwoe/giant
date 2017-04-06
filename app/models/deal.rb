class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment

  enum status: [:uncommented, :commented]

  scope :last3d, -> { where(created_at: (1.day.ago)..(4.day.ago)) }
  include Queriable

end
