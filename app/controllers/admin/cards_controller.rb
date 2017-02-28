class Admin::CardsController < Admin::BaseController
  def index
    current_user.dadi? ? set_dadi_cards : set_cards
    @actived_cards_count = Card.actived.count
    @inactived_cards_count = Card.count - @actived_cards_count
  end

  def update

  end

  private

  def set_cards
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

  def set_dadi_cards
    if params[:actived].present?
      if params[:actived] == 'true'
        @cards = Card.dadi.actived.page(params[:page])
      elsif params[:actived] == 'false'
        @cards = Card.dadi.where(status: nil).page(params[:page])
      end
    else
      @cards = Card.page(params[:page])
    end
  end
end
