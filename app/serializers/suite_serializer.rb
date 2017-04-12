class SuiteSerializer < ActiveModel::Serializer
  attributes :name, :origin_price, :sale_price
  has_many :wares, serializer: WareSerializer
end
