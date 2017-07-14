class Deal < ApplicationRecord
  mount_uploader :avatar, CarUploader

  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment, as: :commentable

  enum status: [:uncommented, :commented]

  scope :last3d,  -> { where 'created_at >= ?', 3.days.ago.beginning_of_day }
  scope :last30d, -> { where 'created_at >= ?', 30.days.ago.beginning_of_day }
  scope :today,   -> { where 'created_at >= ?', Time.zone.now.beginning_of_day }
  scope :by_shop, -> (shop) { where 'shop_id = ?', shop.id }

  validates_presence_of :car_id, :shop_id

  include Queriable

  def self.today_deals_count car_id
    where('created_at >=? AND car_id = ?', Time.zone.now.beginning_of_day, car_id)
      .count
  end

end
