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

  def card_count
    card = cards.order(:actived_at => :desc).first
    (card && card.card_times) || 0
  end

  def card_all_count
    cards.sum(:card_times) || 0
  end

  def card
    cards.order(:actived_at => :desc).first
  end


  private

  def upcase_licensed_id
    licensed_id.upcase!
  end
end
