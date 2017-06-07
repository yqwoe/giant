class Admin::ShopsController < Admin::BaseController
  def index
    @shops = Shop.paginate(page: params[:page])
  end
end
