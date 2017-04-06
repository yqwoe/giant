require 'test_helper'

class Api::V1::AuthenticateTest < ActionDispatch::IntegrationTest

  test "can not sign in if devices has more than three users" do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    user4 = create(:user)
    user5 = create(:user)
    device = create(:device)
    create(:devices_and_users_relationship, device_id: device.id, user_id: user1.id)
    create(:devices_and_users_relationship, device_id: device.id, user_id: user2.id)
    create(:devices_and_users_relationship, device_id: device.id, user_id: user3.id)
    create(:devices_and_users_relationship, device_id: device.id, user_id: user4.id)
    post api_v1_authenticate_index_url, params: {
        device_id: device.uuid,
        login: user5.email,
        password: user5.password,
        client_kind: 'car'
      }

     assert_response :unauthorized
     assert_equal JSON.parse(response.body)['message'],
       '一台设备最多可以登陆三个账户, 请更换手机再次登录！'
  end
end
