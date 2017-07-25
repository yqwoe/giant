require 'test_helper'

class Api::V1::PlatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_plates_index_url
    assert_response :success
  end

end
