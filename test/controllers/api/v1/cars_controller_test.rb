require 'test_helper'

class Api::V1::CarsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = create(:user)
    @car_brand = create(:car_brand)
  end

  test "car have been binded" do
    @car_model = create(:car_model, car_brand_id: @car_brand.id)
    @car = create(:car, car_model_id: @car_model.id, user_id: @user.id)
    post api_v1_cars_url, params:{
        car_brand_id: @car_brand.id,
         car_model: @car_model.cn_name,
          licensed_id: @car.licensed_id,
           user_token: @user.authentication_token}
    assert_response :success
    assert_equal JSON.parse(response.body)['message'], '该车牌已经被绑定'
  end

  test "car_model is invalid" do
    @car_model = create(:car_model)
    @car = create(:car, car_model_id: @car_model.id)
    post api_v1_cars_url, params:{
        car_brand_id: @car_brand.id,
         car_model: @car_model.cn_name,
          licensed_id: @car.licensed_id,
           user_token: @user.authentication_token}
    assert_response :success
    assert_equal JSON.parse(response.body)['message'], '无效车型'
  end

  test "car bind success" do
    @car_model = create(:car_model, car_brand_id: @car_brand.id)
    @car = create(:car, car_model_id: @car_model.id)
    @user.cars.build(car_model_id: @car_model.id, licensed_id: '豫A77777')
    @user.save!
    assert true
  end

  test "user not have cars" do
    get api_v1_cars_url, params: {user_token: @user.authentication_token}
    assert_equal JSON.parse(response.body)['message'], '该用户没有绑定任何车辆！'
  end

end
