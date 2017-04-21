class Api::V1::CardsController < Api::V1::BaseController
  def create
    @card = Card.find_by_pin(params[:card_pin])

    render_invalid_card          and return unless @card
    render_card_has_been_actived and return if @card.actived?

    if growing_card? && @card.growing_user.enrolled?
      render_has_been_enrolled and return
    end

    if current_user.cars.exists?
      @car = current_user.cars.find_by_licensed_id params[:licensed_id]

      render json: { success: false, message: '车牌无效！' } and return unless @car

      @car.joined_at ||= Time.zone.now
      @car.valid_at =  growing_card? ? growing_car_valid : car_valid
      @card.transaction do
        @car.save!
        @card.actived!
        @card.actived_at = Time.zone.now
        @card.car_id = @car.id
        @card.save!
        current_user.member!
      end
      render json: { success: true, valid: @car.valid_at }
    else
      render json: {success: false, message: '请先绑定车辆!'}
    end
  end

  private

  def render_has_been_enrolled
    render json: {success: false, message: '很抱歉，每个用户只能参与一次！'}
  end

  def render_invalid_card
    render json: { success: false, message: '激活码无效，请重新输入！' }
  end

  def render_card_has_been_actived
    render json: { success: false, message: '此卡已被激活!'}
  end

  def car_valid
    @car.valid_at ? @car.valid_at + @card.range.month : @card.range.month.from_now
  end

  def growing_car_valid
    @card.growing_user.enrolled!
    @car.valid_at ? @car.valid_at + 15.days : 15.days.from_now
  end

  def growing_card?
    !!@card.pin.match(/G+/)
  end
end
