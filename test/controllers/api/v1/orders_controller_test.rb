require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest

  setup do
    member = create(:user)
    @token = member.authentication_token
  end

  test "create a valid token" do
    post api_v1_orders_path, params: {
      user_token: @token,
      platform: 'ios',
      total_amount: 990,
      subject: 'VIP',
      body: 'become VIP'
    }

    assert_response :success
    #TODO: check alipay string
     #assert_equal JSON.parse(response.body)['order_string'], 'as'
  end

  test "should bind cars" do

  end
end
