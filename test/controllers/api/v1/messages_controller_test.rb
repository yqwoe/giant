require 'test_helper'

class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @message = create(:message,msg_id:1232)
    end

    test "show message success" do
      get api_v1_message_url(@message.msg_id)
      assert_response :success
      assert_equal JSON.parse(response.body)['success'], true
    end

    test "no types message" do
      get api_v1_message_url('invalid msg_id')
      assert_response :success
      assert_equal JSON.parse(response.body)['message'], '没有此消息!'
    end
end
