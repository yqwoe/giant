class Api::V1::DealsController <  Api::V1::BaseController
  HOSTNAME = 'https://autoxss.com/'

  def index
    records = []

    if current_user.member?
      records = get_member_deals
    elsif current_user.shop_owner?
      records = get_shop_deals
    end

    render json: { record_num: @deals_count, record: records }
  end

  def show
    current_user.deals.find params[:id]
  end

  def qrcode
    # generate hash licensed_id + timestamp
    # save to redis
    # set expired by 5 minute
    # send to member app
    render json: {success: false,
      message: "请提供设备ID"} and return unless params[:device_id].present?

    ##
    # redis set
    # EX seconds -- Set the specified expire time, in seconds.
    # PX milliseconds -- Set the specified expire time, in milliseconds.
    # NX -- Only set the key if it does not already exist.
    # XX -- Only set the key if it already exist.
    if $redis.exists(params[:device_id])
      $redis.del(params[:device_id])
    end

    rand_pin = generate_rand_pin

    # keep a little more time for shops end
    if $redis.set(params[:device_id], rand_pin, ex: 35, nx: true)
      render json: {success: true,
                    rand_pin: rand_pin,
                    expired: 30,
                    timestamp: Time.zone.now.to_i
      }
    end
  end

  def create
    # deal = current_user.deals.build
    # car = Car.find_by licensed_id: params[:licensed_id]
    # render json: { success: false, message: '此车不存在' } and return unless car
    # deal.car_id = car.id
    # #TODO: think about multi shops
    # deal.shop_id = current_user.shops.first.id
    # deal.cleaned_at = Time.zone.now

    # if current_user.save
    #   render json: { success: true, message: '洗车记录已经创建！' }
    # else
    #   render json: { success: false, message: current_user.errors.messages }
    # end
    render json: { success: true}
  end

  private
    def generate_rand_pin
      rand_pin = ''

      loop do
        rand_pin = SecureRandom.hex(12)
        break if rand_pin
      end

      rand_pin
    end

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
      shop = current_user.shops.first

      page = params[:page] || 1
      per_page = params[:per_page] || shop.deals.count
      records = []
      deals   = shop.deals.includes(:car)

      if params[:start].present? && params[:end].present?
        deals = deals.where("created_at >= ? and created_at <= ?",
                       "#{params[:start]} 00:00", "#{params[:end]} 23:59")
      end

      @deals_count = deals.size

      deals.order(id: :desc)
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
