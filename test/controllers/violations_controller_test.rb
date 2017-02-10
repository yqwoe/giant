require 'test_helper'

class ViolationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get violations_create_url
    assert_response :success
  end

  test "should get index" do
    get violations_index_url
    assert_response :success
  end

end
