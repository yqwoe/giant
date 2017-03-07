require 'helpers/users_log_in'

class Admin::CardsControllerTest < ActionDispatch::IntegrationTest

  test "Dadi insuerance should read this page" do
    get admin_cards_url
    assert_response 302
    sign_in_as(@user)
    assert_select ''
  end
end
