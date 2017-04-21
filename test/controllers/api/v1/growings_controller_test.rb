require 'test_helper'

class Api::V1::GrowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_growings_create_url
    assert_response :success
  end

end
