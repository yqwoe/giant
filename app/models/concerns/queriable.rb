module Queriable
  extend ActiveSupport::Concern

  module ClassMethods

    [:year, :month, :day].each do |date_unit|
      define_method("by_#{date_unit}", lambda { |column, date_param|
        where("extract(#{date_unit} from #{column}) = ?", date_param)
      })
    end

    def by_year_and_month column, year, month
      where("extract(YEAR from #{column}) = ?", year).
      where("extract(MONTH from #{column}) = ?", month)
    end
  end
end
