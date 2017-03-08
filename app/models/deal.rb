class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :shop
  belongs_to :user
  has_one :comment

  enum status: [:uncommented, :commented]

  include Queriable

  def self.to_csv(options={})
    CSV.generate(options) do |csv|
      csv << column_names
      limit(100).each do |deal|
        csv << deal.attributes.values_at(*column_names)
      end
    end
  end
end
