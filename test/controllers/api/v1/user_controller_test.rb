require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'send pin' do
    get send_pin_api_v1_users_url
    assert_response :success
  end

  test '#create' do
    @user = create(:user, pin: '1234')
    post api_v1_users_url, params: {mobile: @user.mobile, password: '12341234' }
    assert_response :success
  end
end
