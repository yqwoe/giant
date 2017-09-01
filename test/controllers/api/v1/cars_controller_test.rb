require 'test_helper'

class Api::V1::CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user       = create(:user)
    @car_brand  = create(:car_brand)
    @car_model = create(:car_model, car_brand_id: @car_brand.id)
    @car        = create(:car, user_id: @user.id, car_model_id: @car_model.id)
    @shop_owner = create(:user, roles: :shop_owner)
    @shop       = create(:shop, user_id: @shop_owner.id)
  end

  test "car have been binded" do
    @car_model = create(:car_model, car_brand_id: @car_brand.id)
    @car.update_attributes(car_model_id: @car_model.id, user_id: @user.id)
    post api_v1_cars_url, params: car_params
    assert_response :success
    assert_equal    json_response[:message], "车牌已经与#{@user.mobile}绑定"
  end

  test "car bind success" do
    @car_model = create(:car_model, car_brand_id: @car_brand.id)
    @car.update_attributes(car_model_id: @car_model.id)
    @user.cars.build(car_model_id: @car_model.id, licensed_id: '豫A77777')
    assert true, @user.save!
  end

  ##
  # Car#wash
  #
  test "return false if car not exist" do
    post api_v2_wash_url, params: {
      user_token:  @user.authentication_token,
      qrcode_info: "l=licensed_id%26did=12345%26h=7d45c15c36f6ff852cfa61ca"
    }

    assert_response :success
    assert_not   json_response[:success]
    assert_equal json_response[:message], '您的账户没有该车辆!'
  end

  test "return false if user is not member" do
    post_wash

    assert_response :success
    assert_not   json_response[:success]
    assert_equal json_response[:message], '您的账户没有该车辆!'
  end

  test "car in service" do
    @user.member!
    @car.update_attributes(valid_at: 1.month.from_now,
                           user_id: @user.id)

    post_wash

    assert_response :success
    assert_equal 0, json_response #[:code]
  end

  test "car is not in service if cars expired" do
    @car.valid_at = 1.day.ago
    @car.save!

    post_wash

    assert_response :success
    assert_not json_response[:member]
  end

  test "car is not in service if car's valid is not set" do
    @car.valid_at = nil
    @car.save!

    post_wash

    assert_response :success
    assert_not json_response[:member]
  end

  test "car is still still in service if car has washed today" do
    @car.update_attributes(valid_at: 1.day.from_now)
    @user.member!

    2.times { create(:deal, car_id: @car.id, created_at: Time.zone.now) }

    post_wash

    assert_response :success
    assert_equal 0, json_response[:code]
  end

  test "too often washing can not verified" do
    @car.update_attributes(valid_at: 1.day.from_now)
    @user.member!

    8.times { create(:deal,
                     car_id: @car.id,
                     shop_id: @shop.id,
                     created_at: Time.zone.now)
    }

    post_wash

    assert_response :success
    assert_not json_response[:member]
  end

  test "users limited times wash" do
    @account = create(:account, user: @user)

    post api_v2_wash_url, params: {
      user_token: @shop_owner.authentication_token,
      qrcode_info: "l=#{@car.licensed_id}"
    }

    assert_response :success
    assert json_response[:success]
  end

  private

  def post_wash
    post api_v2_wash_url, params: {
      user_token:  @user.authentication_token,
      shop_id:     @shop.id,
      licensed_id: "豫A88888",
      qrcode_info: "l=#{@car.licensed_id}"
    }
  end

  def car_params
    {
      car_brand_id:  @car_brand.id,
      car_model:     @car_model.cn_name,
      licensed_id:   @car.licensed_id,
      user_token:    @user.authentication_token
    }
  end

end
