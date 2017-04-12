class WareSerializer < ActiveModel::Serializer
  belongs_to :suite
  attributes :origin_price, :sale_price, :name
end
