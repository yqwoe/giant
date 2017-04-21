require 'test_helper'

class Api::V1::CardsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # step 1:  初始化数据
  # step 2:  使用http动作请求服务器
  # step 3： 验证服务器返回的代码
  # step 4： 验证返回的数据

  setup do
    @user = create(:user)
    @card = create(:card)
  end

  test "valid card can active car" do
    @car = create(:car, user_id: @user.id)
    post_cards @card.pin
    assert_response :success
    assert json_response[:success]

    @growing_user = create(:growing_user)
    @growing_card = create(:card, growing_user_id: @growing_user.id)
    @growing_card.update_attributes(pin: "G#{@growing_card.pin}")

    post_cards @growing_card.pin
    assert_response :success
    assert json_response[:success]
    assert_equal 45.days.from_now.strftime('%Y-%m-%d'), json_response[:valid]
  end

  test "growing user could only actived once" do
    @car = create(:car, user_id: @user.id)
    @growing_user = create(:growing_user, status: :enrolled)
    @growing_card = create(:card, growing_user_id: @growing_user.id)
    @growing_card.update_attributes(pin: "G#{@growing_card.pin}")

    post_cards @growing_card.pin
    assert_response :success
    assert_not json_response[:success]
  end

  test "active with invalid card pin" do
    @card = Card.find_by_pin('invalid card pin')
    post api_v1_cards_url, params: {user_token: @user.authentication_token}
    assert_response :success
    assert_equal JSON.parse(response.body)['message'], '激活码无效，请重新输入！'
  end

  test "active when card actived" do
      @card.actived!
      post api_v1_cards_url, params: {user_token: @user.authentication_token, card_pin: @card.pin}
      assert_response :success
      assert_equal JSON.parse(response.body)['message'], '此卡已被激活!'
  end

  test "active when car license id invalid" do
      @car = create(:car, user_id: @user.id)
      post api_v1_cards_url, params: {user_token: @user.authentication_token, card_pin: @card.pin, licensed_id: 'invlid licensed_id'}
      assert_response :success
      assert_equal JSON.parse(response.body)['message'], '车牌无效！'
  end

  test "actived when car not bind" do
    post api_v1_cards_url, params: {user_token: @user.authentication_token, card_pin: @card.pin,}
    assert_response :success
    assert_equal JSON.parse(response.body)['message'], '请先绑定车辆!'
  end

  private

  def post_cards pin
    post api_v1_cards_url, params: {
        user_token:  @user.authentication_token,
        card_pin:    pin,
        licensed_id: @car.licensed_id
      }
  end
end
