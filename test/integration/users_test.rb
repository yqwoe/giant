require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:user)
  end

  test "user should login with mobile" do
    visit user_session_url
    assert_text 'Log in'

    fill_in 'Login',    with: @user.mobile
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    assert_text 'Admin'
   end

  test "user should login with email" do
    visit user_session_url
    assert_text 'Log in'

    fill_in 'Login',    with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    assert_text 'Admin'
  end
end
