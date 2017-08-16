class Account < ApplicationRecord
  belongs_to :user

  def left_times
    current = Date.current
    left    =
      (valid_to.year * 12 + valid_to.month) - (current.year * 12 + current.month)

    this_month_deals_count > 0 ? left - 1  : left
  end

  private

  def this_month_deals_count
    user.deals.this_month.count
  end
end
