class Api::V1::MessagesController < ActionController::API
  before_action :set_message, only: [:show]
  respond_to :json

  def index
    @messages = Message.all
    render json: {success: true, content: @messages.to_json}
  end

  def show
    if @message
      render json: {success: true, content: @message.to_json}
    else
      render json: {success: false, message: '没有此消息!'}
    end
  end

  def create
  end

  private

    def set_message
      @message = Message.find_by msg_id: params[:id]
    rescue
      @message = nil
    end
end
