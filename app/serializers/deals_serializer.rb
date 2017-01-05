class DealsSerializer < ActiveModel::Serializer
  attributes :title, :date, :time, :address

  belongs_to :car_id
  belongs_to :shop_id
end
