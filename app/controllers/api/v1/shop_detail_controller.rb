class Api::V1::ShopDetailController < ActionController::API
  before_action :set_shop, only: [:show]
  def show
    suites =
      @shop.suites.includes(:wares).paginate(page: params[:page], per_page: params[:per_page])
    serialize_suites =
      ActiveModelSerializers::SerializableResource.new(suites)
    render json: {
      shop_detail: ShopDetailSerializer.new(@shop),
      comments_count: @shop.comments.count,
      suites: serialize_suites
    }
  end

  private

  def set_shop
    @shop = Shop.find params[:id]
  rescue Exception => e
    render json: {success: false, message: e.message}
  end
end
