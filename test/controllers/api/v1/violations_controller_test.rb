require 'test_helper'

class Api::V1::ViolationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_violations_create_url
    assert_response :success
  end

  test "should get index" do
    get api_v1_violations_index_url
    assert_response :success
  end

end
