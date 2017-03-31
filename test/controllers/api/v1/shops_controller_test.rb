require 'test_helper'

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest
  test '#search with newer timestamp' do
    @shop = create(:shop)
    get search_api_v1_shops_url, params: { timestamp: Time.now }
    assert_response :success
    assert_equal response.body, '[]'
  end

  test '#search with older timestamp' do
    @shop = create(:shop)
    get search_api_v1_shops_url, params: { timestamp: 1.year.ago }
    assert_response :success
    assert_equal JSON.parse(response.body)[0]['name'], @shop.name
  end
end
