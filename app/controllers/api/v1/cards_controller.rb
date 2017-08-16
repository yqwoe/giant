class Api::V1::CardsController < Api::V1::BaseController
  def create
    @card = Card.find_by_pin(params[:card_pin])

    render_invalid_card          and return unless @card
    render_card_has_been_actived and return if     @card.actived?

    ##
    # 激活次卡
    #
    if times_card?
      account = if current_user.account
                  current_user.account
                else
                  current_user.build_account
                end
      @card.transaction do
        account.deposit_by_times = if account.deposit_by_times
                                     account.deposit_by_times + @card.range
                                   else
                                     @card.range
                                   end
        account.valid_from ||= Time.zone.now

        if account.valid_to && account.valid_to >= Time.zone.now
          account.valid_to += @card.range.month
        else
          account.valid_to = @card.range.month.from_now
        end

        account.save

        @card.active!
        @card.user_id = current_user.id
        @card.save
      end

      account.reload

      render json: {
        success: true,
        valid:      account.valid_to,
        left_times: account.left_times
      } and return
    end

    ##
    # 期间卡激活流程
    #
    render json: {
      success: false,
      message: '请先绑定车辆!'
    } and return unless current_user.cars.exists?

    @car = current_user.cars.find_by_licensed_id params[:licensed_id]

    render json: {
      success: false,
      message: '车牌无效！'
    } and return unless @car

    @car.joined_at ||= Time.zone.now
    @car.valid_at  =  negative_range? ? growing_car_valid : car_valid
    @card.transaction do
      @car.save!
      @card.actived!
      @card.actived_at = Time.zone.now
      @card.car_id = @car.id
      @card.save!
      current_user.member!
    end

    render json: { success: true, valid: @car.valid_at }
  end

  private

  def times_card?
    !!@card.cid.match(/TIMES12/)
  end

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
    !!@card.pin.match(/^(520)+/)
  end

  def negative_range?
    @card.range < 0
  end
end
