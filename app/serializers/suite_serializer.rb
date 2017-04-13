class SuiteSerializer < ActiveModel::Serializer
  attributes :name, :origin_price, :sale_price, :tags, :avatar
  has_many :wares, serializer: WareSerializer
end
