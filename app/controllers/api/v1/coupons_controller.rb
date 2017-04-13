class Api::V1::CouponsController < Api::V1::BaseController
  def index
    render json: Coupon.all
  end
end
