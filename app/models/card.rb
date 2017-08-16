class Card < ApplicationRecord
  include Queriable

  belongs_to :car
  belongs_to :growing_user
  belongs_to :user

  validates_uniqueness_of :cid, :pin

  enum status: [:inactived, :actived]
  enum channel: [:dadi, :zhongyuan, :zhumadian, :growing, :zhumadian_dadi, :zhou]

  def is_actived?
    actived? ? '已激活' : '未激活'
  end

  def active!
    return if actived?

    self.actived_at = Time.zone.now
    actived!
    save
  end
end
