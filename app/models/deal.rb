class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment

  enum status: [:uncommented, :commented]

  include Queriable

  def self.today_deal_count car_id
    where(car_id: car_id, created_at: Time.zone.today).count
  end

end
