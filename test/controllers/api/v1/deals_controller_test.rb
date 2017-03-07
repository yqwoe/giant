require 'test_helper'

class Api::V1::DealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_deals_url
    assert_response :unauthorized
  end
end
