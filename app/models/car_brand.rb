class CarBrand < ApplicationRecord
  after_save :set_initial_letter, on: :create

  has_many :car_models

  ('a'..'z').to_a.each do |cars|
    scope cars, -> { where(initial_letter: cars.upcase) }
  end


  private

  def set_initial_letter
    self.initial_letter ||= PinYin.of_string(self.cn_name).first.first.upcase
    save
  end
end
