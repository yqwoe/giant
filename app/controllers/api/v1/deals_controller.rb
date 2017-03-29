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

  def qrcode
    # generate hash licensed_id + timestamp
    # save to redis
    # set expired by 5 minute
    # send to member app
    render json: {success: false, message: "请提供设备ID"} and return unless params[:device_id].present?

    rand_pin = SecureRandom.hex(12)
    if $redis.set(params[:device_id], rand_pin, ex: 30, nx: true )
      render json: {success: true, rand_pin: rand_pin, expired: 30}
    else
      render json: {success: false, message: "请稍后再试"}
    end
  end

  def create
    verify_qrcode

    car = check_car_licensed_id

    deal = current_user.deals.build

    deal.car_id = car.id
    #TODO: think about multi shops
    deal.shop_id = current_user.shops.first.id
    deal.cleaned_at = Time.now

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

    def verify_qrcode
      valid = false
      # car wash frequency
      deal_count = Deal.last3d
         .where('car_id = ?', Car.find_by_licensed_id(params[:licensed_id]).id)
         .count
      valid = false if deal_count >= 2

      # verify rand_pin
      rand_pin = params[:rand_pin]
      device_id = params[:device_id]
      if rand_pin == $redis.get(device_id)
        valid = true
      end

      render json: {success: false, message: '数据异常'} and return unless valid
    end

    def check_car_licensed_id
      car = Car.find_by_licensed_id params[:licensed_id]
      unless car
        render json: {success: false, message: '该辆车不存在！'} and return
      end

      car
    end
end
