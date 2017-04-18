class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment

  enum status: [:uncommented, :commented]

  include Queriable

  def self.today_deals_count car_id
    where('created_at >=? AND car_id = ?', Time.zone.now.beginning_of_day, car_id)
      .count
  end

end
