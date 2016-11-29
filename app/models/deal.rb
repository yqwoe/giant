class Deal < ApplicationRecord
  belongs_to :dealsable, polymopyic: true
end
