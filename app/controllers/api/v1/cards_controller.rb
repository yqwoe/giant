class Api::V1::CardsController < Api::V1::BaseController
  def create
    card = Card.find_by_pin(params[:card_pin])

    render json: {success: false, message: 'Invalid card!'} unless card

    if card.activited?
      render json: { success: false, message: 'Your card has been activited!'}
    end
    if current_user.cars.exists?
      car = current_user.cars.find_by_licensed_id params[:licensed_id]
      car.joined_at ||= Time.zone.now
      car.valid_at = car.valid_at ? car.valid_at + 1.year : Time.zone.now + 1.year
      card.transaction do
        car.save!
        card.activited!
      end
      render json: { success: true, valid: car.valid_at }
    else
      render json: {success: false, message: 'Please bind a car at first!'}
    end
  end
end
