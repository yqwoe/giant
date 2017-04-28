require 'test_helper'

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest
    test "create comment success" do
      @user = create(:user)
      @deal = create(:deal)
      comment_content = "This is a comment."
      post api_v1_comments_url, params:{deal_id: @deal.id,
                                        content: comment_content,
                                        clean_star: 5,
                                        service_star: 5,
                                        env_star: 5,
                                        user_token: @user.authentication_token}
      assert_response :success
      assert_equal json_response[:comment][:content], comment_content
    end

    test "deal id can't be nil" do
        @user = create(:user)
        @deal = create(:deal)
        @comment = create(:comment, deal_id: @deal.id)
        post api_v1_comments_url, params:{deal_id: 'invalid deal_id',
                                        content: @comment.content,
                                        clean_star: 5,
                                        service_star: 5,
                                        env_star: 5,
                                        user_token: @user.authentication_token}
        assert_response :success
        assert_equal json_response[:message], '订单ID不能为空！'
    end
end
