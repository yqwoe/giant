class Api::V1::AdsController < ActionController::API
  include ActionView::Helpers::AssetUrlHelper

  def show
    @ad = Ad.find params[:id]
    if @ad
      render json: { success: true, message:{ img_url: asset_url("assets/#{@ad.img_url}") } }
    end
  rescue Exception => e
    render json: { success: false, message: { error: e.message }}
  end
end
