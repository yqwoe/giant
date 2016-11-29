class CarBrand < ApplicationRecord
  has_many :car_models

  scope :a, -> { where(initial_letter: 'A') }

  ('A'..'Z').to_a.each do |cars|
    scope cars, -> { where(initial_letter: cars) }
  end

end
