class Admin::CardsController < Admin::BaseController
  def index
    set_cookies
    if current_user.dadi?
      set_dadi_cards
      @actived_cards_count = dadi_actived_cards_count
      @inactived_cards_count = dadi_inactived_cards_count
    elsif current_user.zhumadian_dadi?
      set_zhumadian_dadi_cards
      @actived_cards_count = zhumadian_dadi_actived_cards_count
      @inactived_cards_count = zhumadian_dadi_inactived_cards_count
    elsif current_user.zhou?
      set_zhou_cards
      @actived_cards_count = zhou_actived_cards_count
      @inactived_cards_count = zhou_inactived_cards_count
    elsif current_user.admin?
      set_cards
      @actived_cards_count = Card.actived.count
      @inactived_cards_count = Card.count - @actived_cards_count
    end

    respond_to do |format|
      format.html
      format.xls {
        @cards = set_cards_for_excel
        render layout: "application"
      }
    end
  end

  def update

  end

  private

  def set_cookies
    cookies[:actived]  = !!params[:actived]
  end

  def set_cards_for_excel
    if current_user.dadi?
      Card.dadi
    elsif current_user.zhumadian_dadi?
      Card.zhumadian_dadi
    elsif params[:actived].present? and current_user.admin?
      params[:actived] ? Card.actived : Card.where(status: nil)
    elsif params[:actived].present? and current_user.zhou?
      Card.zhou
    elsif current_user.admin?
      Card.all
    end
  end

  def set_cards
    if params[:actived].present?
      if params[:actived] == 'true'
        @q = Card.actived.ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      elsif params[:actived] == 'false'
        @q = Card.where(status: nil).ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      end
    else
      @q = Card.ransack(params[:q])
      @cards = @q.result.includes(:car).page(params[:page])
    end
    @cards_count = Card.count
  end

  def set_dadi_cards
    if params[:actived].present?
      if params[:actived] == 'true'
        @q = Card.all_of_dadi.actived.ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      elsif params[:actived] == 'false'
        @q = Card.all_of_dadi.where(status: nil).ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      end
    else
      @q = Card.all_of_dadi.ransack(params[:q])
      @cards = @q.result.includes(:car).page(params[:page])
    end
    @cards_count = Card.all_of_dadi.count
  end

  def set_zhou_cards
    if params[:actived].present?
      if params[:actived] == 'true'
        @q = Card.zhou.actived.ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      elsif params[:actived] == 'false'
        @q = Card.zhou.where(status: nil).ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      end
    else
      @q = Card.zhou.ransack(params[:q])
      @cards = @q.result.includes(:car).page(params[:page])
    end
    @cards_count = Card.zhou.count
  end

  def zhou_actived_cards_count
    Card.zhou.actived.count
  end

  def zhou_inactived_cards_count
    Card.zhou.count - Card.zhou.inactived.count
  end

  def dadi_actived_cards_count
    Card.dadi.actived.count
  end

  def dadi_inactived_cards_count
    Card.dadi.count - Card.dadi.actived.count
  end

  def set_zhumadian_dadi_cards
    if params[:actived].present?
      if params[:actived] == 'true'
        @q = Card.zhumadian_dadi.actived.ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      elsif params[:actived] == 'false'
        @q = Card.zhumadian_dadi.where(status: nil).ransack(params[:q])
        @cards = @q.result.includes(:car).page(params[:page])
      end
    else
      @q = Card.zhumadian_dadi.ransack(params[:q])
      @cards = @q.result.includes(:car).page(params[:page])
    end
    @cards_count = Card.zhumadian_dadi.count
  end

  def zhumadian_dadi_actived_cards_count
    Card.zhumadian_dadi.actived.count
  end

  def zhumadian_dadi_inactived_cards_count
    Card.zhumadian_dadi.count - Card.zhumadian_dadi.actived.count
  end
end
