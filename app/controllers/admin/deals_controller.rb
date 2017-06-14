class Admin::DealsController < Admin::BaseController
  before_action :authenticate_admin?
  before_action :set_shop

  def index
    if params[:shop_id].present?
      @deals = @shop.deals.includes(car: [:user])
        .order(shop_id: :desc)
        .page(params[:page])
    else
      @deals = Deal.includes(:shop, car: [:user])
        .order(id: :desc)
        .page(params[:page])
    end
    respond_to do |format|
      format.html
      format.csv { render text: @deals.to_csv }
      format.xls do
        @deals = Deal.includes(:shop, car: [:user]).all
        send_data render_to_string stream: true
      end
    end

  end

  private
    #TODO: import cancancan gem
    def authenticate_admin?
      render text: '请和管理员联系！' unless current_user.admin?
    end

    def last_month
      Time.zone.now.last_month.month
    end

    def set_shop
      if params[:shop_id].present?
        @shop = Shop.with_deleted.find params[:shop_id]
      end
    end
end
