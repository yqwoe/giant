require 'test_helper'

class Api::V1::PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = create(:user)
    @car    = create(:car, user_id: @member.id)
    @order  = create(:order, car_id: @car.id)
  end

  test "directly return if order has finished" do
    @order.success!
    post api_v1_payments_path, params: payment_params

    assert json_response[:success]
    assert_match(/已经激活/, json_response[:message])
  end

  test "add or extend VIP membership" do
    post api_v1_payments_path, params: payment_params

    @order.reload
    @car.reload
    assert @order.success?
    assert_equal @car.valid_at, 1.year.from_now.to_date
    assert json_response[:message]
  end


  private

  def payment_params
    {
      total_amount:      0.01,
      buyer_id:          '2088002340337660',
      trade_no:          '2017050521001004660202926693',
      body:              'becomeVIP',
      notify_time:       '2017-05-05 14:56:28',
      subject:           'VIP',
      sign_type:         'RSA',
      buyer_logon_id:    'roc***@yahoo.com.cn',
      auth_app_id:       '2016111802958037',
      charset:           'utf-8',
      notify_type:       'trade_status_sync',
      invoice_amount:    '0.01',
      trade_status:      'TRADE_SUCCESS',
      gmt_payment:       '2017-05-05 14:56:2a8',
      version:           1.0,
      point_amount:      0.00,
      sign:              'iDZ7wxvI/dOEcluHO1efJNFiqcxzV+7tPDm5xfIf6PeU3t3XtJy/Q5K428CtNj/0UP1wPZtZMbubDg/SEt+Kd/zy3diaGofa066jAZQmpTssG99lkb2OTmQe0qUOwLaSH29eFcFgk8i1tQT8wb3UVhxk+XScgY8r6mz8i24uVE4=',
      gmt_create:        '2017-05-05 14:56:28',
      buyer_pay_amount:   0.01,
      receipt_amount:     0.01,
      fund_bill_list:     '[{"amount":"0.01","fundChannel":"ALIPAYACCOUNT"}]',
      app_id:             '2016111802958037',
      seller_id:          '2088221491093746',
      notify_id:          'f8f8c4c65f0389c4fcbccd22d700413l3e',
      seller_email:       '1991996789@qq.com',
      'out_trade_no':       'ios20170505153834959'
    }
  end
end
