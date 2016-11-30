class Deal < ApplicationRecord
  belongs_to :dealsable, polymorphic: true
end
