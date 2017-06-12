class Admin::DealsController < Admin::BaseController
  before_action :authenticate_admin?

  def index
    @deals = Deal.includes(:shop, car: [:user])
      .order(:shop_id)
      .page(params[:page])
    respond_to do |format|
      format.html
      format.csv { render text: @deals.to_csv }
      format.xls { @deals = Deal.by_month(:created_at, last_month)}
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
end
