class Api::V1::CardsController < Api::V1::BaseController
  def create
    card = Card.find_by_pin(params[:card_pin])

    render json: { success: false, message: 'Invalid card!' } and return unless card

    if card.actived?
      render json: { success: false, message: 'Your card has been activited!'} and return
    end

    if current_user.cars.exists?
      car = current_user.cars.find_by_licensed_id params[:licensed_id]

      render json: { success: false, message: 'Car ID is not exist!' } and return unless car

      car.joined_at ||= Time.zone.now
      car.valid_at = car.valid_at ? car.valid_at + 1.year : Time.zone.now + 1.year
      card.transaction do
        car.save!
        card.actived!
        card.actived_at = Time.zone.now
        card.car_id = car.id
      end
      render json: { success: true, valid: car.valid_at }
    else
      render json: {success: false, message: 'Please bind a car at first!'}
    end
  end
end
