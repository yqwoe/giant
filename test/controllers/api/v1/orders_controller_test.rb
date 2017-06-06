require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @member = create(:user)
    @car    = create(:car, user_id: @member.id)
    @token  = @member.authentication_token
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

  test "car can not be nil" do
    post api_v1_orders_path, params: {
      user_token: @token,
      platform: 'ios',
      total_amount: 990,
      subject: 'VIP',
      body: 'become VIP',
      licensed_id: 'null'
    }

    assert_response :success
    assert_match(/添加车辆/, response.body)
  end

  test "create order correctlly" do
    Timecop.freeze(Time.local(2017, 06, 06, 10, 35, 42,600))
    post api_v1_orders_path, params: {
      user_token: @token,
      platform: 'ios',
      total_amount: 990,
      subject: 'VIP',
      body: 'become VIP',
      licensed_id: @car.licensed_id
    }

    Timecop.return
    assert json_response[:success]
    assert_equal json_response[:order_string], order_string
  end

  test "params missing" do
    post api_v1_orders_path, params: {
      body:         'become VIP',
      subject:      'VIP',
      user_token:   @token,
      licensed_id:  @car.licensed_id,
      total_amount: 990,
    }

    assert_match(/非法参数/, response.body)
  end

  private

  def order_string
    "app_id=2016111802958037&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22seller_id%22%3A%22%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A880%2C%22subject%22%3A%22VIP%22%2C%22body%22%3A%22becomeVIP%22%2C%22out_trade_no%22%3A%22ios20170606103542000%22%7D&charset=utf-8&method=alipay.trade.app.pay&notify_url=http%3A//www.example.com/api/v1/payments&sign_type=RSA&timestamp=2017-06-06%2010%3A35%3A42&version=1.0&sign=l5Nm9KI1ZIGRIR7QcXc1RcO0lg6CzCsJIrhi%2FXjXzCHvepNuW3fRhxSNkHD1z0nOIxdkMlkR6FaVFEgR6ySxiyBpqJZu%2BqJ2YYE6yjqsyvnqm6pabRTPOf5kqF%2BvBcqQYs7wgwq611MVxcDB18UWeVR%2BXJ8TE7DbwyXDghmazyY%3D".freeze
  end
end
