class Admin::DealsController < Admin::BaseController
  def index
    @deals = Deal.page(params[:page])
  end
end
