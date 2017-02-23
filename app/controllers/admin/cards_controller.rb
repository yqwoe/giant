class Admin::CardsController < Admin::BaseController
  def index
    if params[:actived].present?
      if params[:actived] == 'true'
        @cards = Card.actived.page(params[:page])
      elsif params[:actived] == 'false'
        @cards = Card.where(status: nil).page(params[:page])
      end
    else
      @cards = Card.page(params[:page])
    end
  end

  def update

  end
end
