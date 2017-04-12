class Api::V1::ShopDetailController < ActionController::API
  before_action :set_shop, only: [:show]
  def show
    render json: {
      shop_detail: @shop,
      comments_count: @shop.comments.count,
      wares: @shop.wares.page(params[:page]).per_page(params[:per_page])
    }
  rescue
  end

  private

  def set_shop
    @shop = Shop.find params[:id]
  rescue
    render json: {success: false}
  end
end
