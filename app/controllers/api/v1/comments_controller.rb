class Api::V1::CommentsController < Api::V1::BaseController
  def index
    render json: current_user.comments
  end

  def show
    render json: Comment.find(params[:id])
  end

  def create
    unless params[:content].present?
      render json: { success: false, message: 'comment can not be nil' } and return
    end
    if @deal = Deal.find(params[:deal_id])
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
end
