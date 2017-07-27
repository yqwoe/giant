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

  def show
    if params[:car_id].present?
      car = Car.find params[:car_id]
      @deals = car.deals
                  .includes(:shop)
                  .order(created_at: :desc).page(params[:page])
    elsif params[:shop_id].present?
      shop = Shop.whith_deleted.find params[:shop_id]
      @deals = shop.deals
                   .includes(car: [:user])
                   .order(created_at: :desc)
                   .page(params[:page])
    end

    respond_to do |format|
      format.html
    end
  end

  def destroy
    @deal = Deal.find params[:id]
    @deal.destroy

    respond_to do |format|
      format.js
    end
  end

  def create
    car = Car.find_by licensed_id: params[:car_licensed_id].strip.upcase

    unless car
      render js: "sweetAlert('车牌号不存在!');" and return
    end

    if car.user.blacklist?
      render js: "sweetAlert('黑名单用户，如需添加，请先重置为会员');" and return
    end

    unless car.valid_at && car.valid_at >= Time.zone.now.beginning_of_day
      render js: "sweetAlert('该车辆为非会员车辆！');" and return
    end

    @deal = Deal.new
    @deal.shop_id = params[:shop_id]
    @deal.memo    = params[:memo]
    @deal.car_id = car.id

    if @deal.save
      respond_to do |format|
        format.js
      end
    else
      render json: @deal.errors.messages
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
