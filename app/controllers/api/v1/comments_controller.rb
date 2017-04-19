class Api::V1::CommentsController < ActionController::API
  before_action :set_shop, only: [:index]

  def index
    render json: @shop.comments
  end

  def show
    render json: Comment.find(params[:id])
  end

  def create
    unless params[:content].present?
      render json: { success: false, message: 'comment can not be nil' } and return
    end
    if @deal = Deal.find_by(id: params[:deal_id])
      @deal.commented!
    else
      render json: { success: false, message: 'deal id can not be nil' } and return
    end

    @comment = @deal.build_comment
    @comment.deal_id = params[:deal_id]
    @comment.content  = params[:content]
    @comment.env_star = params[:env_star]
    @comment.service_star = params[:service_star]
    @comment.clean_star   = params[:clean_star]
    @deal.commented_at = Time.zone.now

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
end
