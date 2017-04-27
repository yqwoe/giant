require 'test_helper'

class Api::V1::ShopCitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_shop_cities_index_url
    assert_response :success
  end

end
