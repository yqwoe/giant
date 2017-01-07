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
    @comment = current_user.comments.build
    @comment.shop_id = params[:shop_id]
    @comment.content = params[:content]
    @comment.env_star = params[:env_star]
    @comment.service_star = params[:service_star]
    @comment.clean_star = params[:clean_star]

    if current_user.save
      render json: { success: true, comment: @comment }
    else
      render json: { success: false, message: @comment.errors.messages  }
    end
  end
end
