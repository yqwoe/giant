class Admin::CardsController < Admin::BaseController
  def index
    if current_user.dadi?
      set_dadi_cards
      @actived_cards_count = dadi_actived_cards_count
      @inactived_cards_count = dadi_inactived_cards_count
    elsif current_user.admin?
      set_cards
      @actived_cards_count = Card.actived.count
      @inactived_cards_count = Card.count - @actived_cards_count
    end
  end

  def update

  end

  private

  def set_cards
    if params[:actived].present?
      if params[:actived] == 'true'
        @q = Card.actived.ransack(params[:q])
        @cards = @q.result.includes(:cars).page(params[:page])
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
        @q = Card.dadi.actived.ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      elsif params[:actived] == 'false'
        @q = Card.dadi.where(status: nil).ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      end
    else
      @q = Card.dadi.ransack(params[:q])
      @cards = @q.result.includes(:car).page(params[:page])
    end
  end

  def dadi_actived_cards_count
    Card.dadi.actived.count
  end

  def dadi_inactived_cards_count
    Card.dadi.count - Card.dadi.actived.count
  end
end
