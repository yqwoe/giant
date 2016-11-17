require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should get show" do
    get api_v1_user_url(@user)
    assert_response :success
  end

end
