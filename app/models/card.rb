class Card < ApplicationRecord
  enum status: [:inactived, :actived]
  enum channel: [:dadi]

  self.per_page = 10

  def is_actived?
    actived? ? '已激活' : '未激活'
  end

end
