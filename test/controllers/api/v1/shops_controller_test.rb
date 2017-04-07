require 'test_helper'

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest
    test "show shop" do
      @shop = create(:shop)
      get api_v1_shop_url(@shop)
      assert_equal JSON.parse(response.body)['name'], @shop.name
    end
end
