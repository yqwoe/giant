class Card < ApplicationRecord
  include Queriable
  belongs_to :car

  validates_uniqueness_of :cid, :pin

  enum status: [:inactived, :actived]
  enum channel: [:dadi, :zhongyuan, :zhumadian]

  self.per_page = 10

  def is_actived?
    actived? ? '已激活' : '未激活'
  end

end
