require 'test_helper'

class Api::V1::ShopDetailControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = create(:shop)
  end

  test "should get index" do
    get api_v1_shop_detail_path(@shop)
    assert_response :success
  end

end
