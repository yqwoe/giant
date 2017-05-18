class Api::V1::CardsController < Api::V1::BaseController
  def create
    @card = Card.find_by_pin(params[:card_pin])

    render_invalid_card          and return unless @card
    render_card_has_been_actived and return if @card.actived?
    if growing_card?
      render json: { success: false, message: '用户不存在' } and return unless @card.growing_user
    end

    if (growing_card? && @card.growing_user.enrolled?)
      render_has_been_enrolled and return
    end

    if (growing_520_card? && @card.growing_user.enrolled_520?)
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
    is_service_expired? ? @card.range.month.from_now : @car.valid_at + @card.range.month
  end

  def growing_car_valid
    @card.growing_user.enrolled!
    is_service_expired? ? expend_days.from_now : @car.valid_at + expend_days
  end

  def expend_days
    @card.range.to_i.abs.days
  end

  def is_service_expired?
    return true unless @car.valid_at
    @car.valid_at < Time.zone.now.beginning_of_day
  end

  def growing_card?
    !!@card.pin.match(/G+/)
  end

  def growing_520_card?
    !!@card.pin.match(/(520)+/)
  end
end
