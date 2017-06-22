require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'send pin' do
  end

  test '#create' do
    post api_v1_users_url, params: {mobile: @user.mobile, password: '12341234' }
    assert_response :success
  end

  test 'valid user should return user information' do
    get api_v1_users_url, params: {user_token: @user.authentication_token}
    assert_response :success
    assert_equal JSON.parse(response.body)['mobile'], @user.mobile
  end

  test 'invalid user should return false' do
    get api_v1_users_url, params: {user_token: "invalid_authentication_token"}
    assert_response :success
    assert_nil JSON.parse(response.body)['mobile']
    assert_equal JSON.parse(response.body)['message'], '该用户不存在'
  end
end
