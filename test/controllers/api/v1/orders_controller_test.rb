require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  ALIPAY_STRING = "app_id=2016111802958037&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22seller_id%22%3A%22%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%22990%22%2C%22subject%22%3A%22VIP%22%2C%22body%22%3A%22becomeVIP%22%2C%22out_trade_no%22%3A%22ios20170327170304462%22%7D&charset=utf-8&method=alipay.trade.app.pay&sign_type=RSA&timestamp=2017-03-27%2017%3A03%3A04&version=1.0&sign=KBD0vGXxGa6o4ygcAbb47XLxpsoDoYJWXBhY28E8Xjcc0PR19yJDYO66aSQ5FvFOqt84u%2B2hblt3xPI3Aw%2BGlgfzW9vwbN8OdSg53ETjn%2B6A1qsAIEyE4ipFZhyUwLUSca3SLPSIXRny8gKaXt7CHgACxMAqsRcGLLfHr0I6utg%3D".freeze

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
    assert JSON.parse(response.body)['order_string'], ALIPAY_STRING
  end
end
