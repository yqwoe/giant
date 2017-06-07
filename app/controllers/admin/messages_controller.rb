class Admin::MessagesController < Admin::BaseController
  def index
    @messages = Message.order('id desc').paginate(page: params[:page])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      JpushJob.perform_later(@message)
      render :show
    else
      render :new
    end
  end

  def show
    @message = Message.find params[:id]
  end

  private

  def message_params
    params.require(:message).permit(:title, :body)
  end
end
