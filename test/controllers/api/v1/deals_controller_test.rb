require 'test_helper'

class Api::V1::DealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user       = create(:user, roles: :member)
    @shop_owner = create(:user, roles: :shop_owner)
    @car  = create(:car, user_id: @user.id)
    @shop = create(:shop, user_id: @shop_owner.id)
    @deal = create(:deal, car_id: @car.id, shop_id: @shop.id)
  end

  test "should get index" do
    get api_v1_deals_url
    assert_response :unauthorized
  end

  test "create deal success" do
    @deal = @user.deals.build(car_id: @car.id, shop_id: @shop.id)
    post api_v1_deals_url, params: {licensed_id: @car.licensed_id,
                                   user_token:@user.authentication_token}
    @user.save!
    assert_response :success
    assert_equal JSON.parse(response.body)['success'], true
  end

  test "member gets his deals" do
    get api_v1_deals_url(user_token: @user.authentication_token)
    assert_response :success
    assert_equal @shop.id, json_response[:record].first[:shop_id]
  end


  test "shop gets its deals" do
    get api_v1_deals_url(user_token: @shop_owner.authentication_token)
    assert_response :success
    assert_equal @car.licensed_id, json_response[:record].first[:licensed_id]
  end
end
