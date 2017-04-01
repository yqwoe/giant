class Api::V1::CardsController < Api::V1::BaseController
  def create
    card = Card.find_by_pin(params[:card_pin])

    render json: { success: false, message: '激活码无效，请重新输入！' } and return unless card

    if card.actived?
      render json: { success: false, message: '此卡已被激活!'} and return
    end

    if current_user.cars.exists?
      car = current_user.cars.find_by_licensed_id params[:licensed_id]

      render json: { success: false, message: '车牌无效！' } and return unless car

      car.joined_at ||= Time.zone.now
      car.valid_at = car.valid_at ? car.valid_at + card.range.month : Time.zone.now + card.range.month
      card.transaction do
        car.save!
        card.actived!
        card.actived_at = Time.zone.now
        card.car_id = car.id
        card.save!
        current_user.member!
      end
      render json: { success: true, valid: car.valid_at }
    else
      render json: {success: false, message: '请先绑定车辆!'}
    end
  end

end
