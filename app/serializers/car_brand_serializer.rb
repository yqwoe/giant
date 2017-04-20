class CarBrandSerializer < CarBrandSimpleSerializer
  has_many :car_models
end
