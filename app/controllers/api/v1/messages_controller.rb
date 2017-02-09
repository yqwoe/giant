class Api::V1::MessagesController < ActionController::API
  before_action :set_message, only: [:show]
  respond_to :json

  def index
    @messages = Message.all
    render json: @messages
  end

  def show
    if @message
      render json: @message
    else
      render json: {success: false, message: '没有此消息!'}
    end
  end

  def create
  end

  private

    def set_message
      @message = Message.find params[:id]
    rescue
      @message = nil
    end
end
