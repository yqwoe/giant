class Api::V1::CommentsController < ActionController::API
  before_action :set_shop, only: [:index]

  def index
    @comments = @shop.comments
    env_star     = @comments.average_env_star
    clean_star   = @comments.average_clean_star
    service_star = @comments.average_service_star

    render json: {
      env_star:     env_star,
      clean_star:   clean_star,
      service_star: service_star,
      comments:     set_comments
    }
  end

  def show
    render json: Comment.find(params[:id])
  end


  def create
    render_comment_cannot_be_nil and return unless params[:content].present?
    @deal = Deal.find_by(id: params[:deal_id])
    render_deal_cannot_be_nil and return unless @deal
    render_already_commented  and return if @deal.commented?

    @comment = @deal.build_comment
    @comment.deal_id      = params[:deal_id]
    @comment.content      = params[:content]
    @comment.env_star     = params[:env_star]
    @comment.service_star = params[:service_star]
    @comment.clean_star   = params[:clean_star]
    @deal.commented_at    = Time.zone.now
    @deal.commented!

    if @deal.save
      @comment.reload
      render json: { success: true, comment: @comment }
    else
      render json: { success: false, message: @comment.errors.messages  }
    end
  end

  private

    def set_shop
      @shop = Shop.find params[:shop_id]
    end

    def set_comments
      comments = []
      @comments.each do |comment|
        user = comment.commentable.car.user
        comments << {
          user_logo: user.avatar || 'https://autoxss.com/logo.png',
          user_name: user.mobile,
          sum_star:  comment.sum_star,
          content:   comment.content
        }
      end

      comments
    end

    def render_comment_cannot_be_nil
      render json: { success: false, message: '评论内容不能为空！' }
    end

    def render_deal_cannot_be_nil
      render json: { success: false, message: '订单ID不能为空！' }
    end

    def render_already_commented
      render json: { success: false, message: '您已经评论过了！' }
    end
end
