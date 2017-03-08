class Admin::DealsController < Admin::BaseController
  before_action :authenticate_admin?

  def index
    @deals = Deal.order(:shop_id).page(params[:page])
    respond_to do |format|
      format.html
      format.csv { render text: @deals.to_csv }
      format.xls { @deals = Deal.all }
    end

  end

  private
    #TODO: import cancancan gem
    def authenticate_admin?
      render text: '请和管理员联系！' unless current_user.admin?
    end
end
