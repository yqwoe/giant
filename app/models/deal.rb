class Deal < ApplicationRecord
  mount_uploader :avatar, CarUploader

  acts_as_paranoid

  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment, as: :commentable

  enum status: [:uncommented, :commented]

  validates_presence_of :car_id, :shop_id #, :avatar

  scope :last3d,  -> { where 'created_at >= ?', 3.days.ago.beginning_of_day }
  scope :last30d, -> { where 'created_at >= ?', 30.days.ago.beginning_of_day }
  scope :today,   -> { where 'created_at >= ?', Time.zone.now.beginning_of_day }
  scope :last4h,  -> { where 'created_at >= ?', 4.hours.ago }
  scope :by_shop, -> (shop) { where 'shop_id = ?', shop.id }
  scope :this_month, -> { where 'created_at >= ?',Time.zone.now.beginning_of_month}

  validates_presence_of :car_id, :shop_id

  include Queriable

  def self.today_deals_count car_id
    where('created_at >=? AND car_id = ?', Time.zone.now.beginning_of_day, car_id)
      .count
  end

end
