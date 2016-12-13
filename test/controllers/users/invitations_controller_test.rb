require 'test_helper'

class Users::InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_invitations_index_url
    assert_response :success
  end

end
