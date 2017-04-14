class Api::V1::CouponsController < Api::V1::BaseController
  def index
    if params[:tag] == 'all' or  Coupon.statuses.include? params[:tag]
      render json: coupon_result
    else
      render json: Coupon.count
    end
  end

  private

  def coupon_result
    Coupon.send params[:tag]
  end
end
