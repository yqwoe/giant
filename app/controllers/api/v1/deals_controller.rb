class Api::V1::DealsController <  Api::V1::BaseController
  HOSTNAME = 'https://autoxss.com/'

  def index
    records = []

    if current_user.member?
      records = get_member_deals
    elsif current_user.shop_owner?
      records = get_shop_deals
    end

    render json: { record: records }
  end

  def show
    current_user.deals.find params[:id]
  end

  def create
    deal = current_user.deals.build
    car = Car.find_by_licensed_id params[:licensed_id]
    unless car
      render json: {success: false, message: '该辆车不存在！'} and return
    end
    deal.car_id = car.id
    #TODO: think about multi shops
    deal.shop_id = current_user.shops.first.id
    deal.cleaned_at = Time.zone.now
    today_deal_count = Deal.today_deal_count car

    if today_deal_count > 0
      render json: { success: false, message: "验证不通过！" } and return
    end

    if current_user.save
      render json: { success: true }
    else
      render json: { success: false, message: current_user.errors.messages }
    end
  end

  private

    def get_member_deals
      return nil unless current_user.member?

      page = params[:page] || 1
      records = []
      Deal.where('car_id IN (?)', current_user.cars.pluck(:id))
        .order(id: :desc)
        .paginate(page: page, per_page: params[:per_page]).each do |deal|
          shop_image = deal&.shop&.image
          records << {
            deal_id: deal.id,
            shop_id: deal&.shop_id,
            title: deal&.shop&.name,
            date:  deal&.cleaned_at&.strftime('%Y-%m-%d'),
            time:  deal&.cleaned_at&.strftime('%H:%M'),
            address: deal&.shop&.address,
            comment: !!deal.status,
            image: "#{HOSTNAME}assets/shops/#{shop_image}"
          }
      end

      records
    end

    def get_shop_deals
      return nil unless current_user.shop_owner?

      page = params[:page] || 1
      per_page = params[:per_page] || current_user.deals.count
      records = []
      current_user.deals.order(id: :desc)
        .page(page)
        .per_page(per_page).each do |deal|
          records << {
            licensed_id: deal&.car&.licensed_id,
            date:  deal&.cleaned_at&.strftime('%Y-%m-%d'),
            time:  deal&.cleaned_at&.strftime('%H:%M'),
            car_brand: deal&.car&.car_model&.car_brand&.cn_name
          }
        end
      records
    end

    def get_car_deals car
      records = []
      car.deals.order(id: :desc).each do |deal|
        shop_image = deal&.shop&.image
        records << {
          deal_id: deal.id,
          shop_id: deal&.shop_id,
          title: deal&.shop&.name,
          date:  deal&.cleaned_at&.strftime('%Y-%m-%d'),
          time:  deal&.cleaned_at&.strftime('%H:%M'),
          address: deal&.shop&.address,
          comment: !!deal.status,
          image: "#{HOSTNAME}assets/shops/#{shop_image}"
        }
      end

      records
    end
end
