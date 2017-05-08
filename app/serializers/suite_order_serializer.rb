class SuiteOrderSerializer < ActiveModel::Serializer
  attributes :suite_name, :shop_name, :price, :transacted_at, :trade_no

  include Camelizable

  def suite_name
    object&.suite&.name
  end

  def shop_name
    object&.suite&.shop&.name
  end

  def transacted_at
    object.created_at
  end
end
