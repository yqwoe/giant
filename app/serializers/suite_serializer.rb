class SuiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :origin_price, :sale_price, :tags, :avatar
  has_many :wares, serializer: WareSerializer
end
