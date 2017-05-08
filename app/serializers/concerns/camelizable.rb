module Camelizable
  extend ActiveSupport::Concern

  def attributes *args
    Hash[super.map do |key, value|
      [key.to_s.camelize(:lower).to_sym, value]
    end
    ]
  end
end
