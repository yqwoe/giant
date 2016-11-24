require 'test_helper'

class Api::V1::UsersTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @token = user.authentication_token
  end

  test "user with invalid token" do
    get api_v1_users_url, params: {user_token: ''}
    assert_response 401
  end

  test "user with valid token" do
    get api_v1_users_url, params: {user_token: @token}
    assert_response 200
  end
end
