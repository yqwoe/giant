require 'test_helper'

class Api::V1::DealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @car = create(:car, user_id: @user.id)
    @shop = create(:shop, user_id: @user.id)
  end
  test "should get index" do
    get api_v1_deals_url
    assert_response :unauthorized
  end

  test "create deal but car not exists" do
      post api_v1_deals_url, params: {licensed_id: 'invalid licensed id',
                                    user_token:@user.authentication_token}
      assert_response :success
      assert_equal JSON.parse(response.body)['message'], '该辆车不存在！'
  end

  test "create deal success" do
    @deal=@user.deals.build(car_id: @car.id,shop_id: @shop.id)
    post api_v1_deals_url, params: {licensed_id: @car.licensed_id,
                                   user_token:@user.authentication_token}
    @user.save!
    assert_response :success
    assert_equal JSON.parse(response.body)['success'], true
  end

end
