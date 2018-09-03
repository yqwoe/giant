class Car < ApplicationRecord
  before_save :upcase_licensed_id

  belongs_to :car_model
  belongs_to :user

  has_many :deals
  has_many :violations
  has_many :cards
  has_many :orders

  enum status: [:trial, :annual]

  #次卡总数量
  def times_card_count
    cards.where("cid like 'TIMES12%' ").sum(:range) || -1
  end

  def active_cards
    ids = cards.order(:actived_at => :desc).select{|c| c.range.month.from_now > Time.now } || []
    cards.where(:id => ids.map{|o| o.id})
  end

  def card_count
    card = active_cards.first
    (card && card.card_times) || 0
  end

  def card_all_count
    active_cards.sum(:card_times) || 0
  end

  def card
    active_cards.first
  end

  def card_valid_from_now
    card.try(:range).month.from_now < Time.now
  end


  private

  def upcase_licensed_id
    licensed_id.upcase!
  end
end
