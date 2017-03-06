require 'test_helper'

class Admin::ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_shops_index_url
    assert_response :success
  end

end
