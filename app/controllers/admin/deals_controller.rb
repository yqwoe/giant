class Admin::DealsController < Admin::BaseController
  def index
    @deals = Deal.order(:shop_id).page(params[:page])
  end
end
