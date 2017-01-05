class Api::V1::DealsController <  Api::V1::BaseController
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

  private

    def get_member_deals
      return nil unless current_user.member?

      records = []
      current_user.cars.each do |car|
        car.deals.order(id: :desc).each do |deal|
          records << {
            title: deal.shop.name,
            date:  deal.cleaned_at.strftime('%Y-%m-%d'),
            time:  deal.cleaned_at.strftime('%H:%M'),
            address: deal.shop.address
          }
        end
      end

      records
    end

    def get_shop_deals
      return nil unless current_user.shop_owner?

      records = []
      current_user.shops.each do |shop|
        shop.deals.order(id: :desc).each do |deal|
          records << {
            licensed_id: deal.car.licensed_id,
            date:  deal.cleaned_at.strftime('%Y-%m-%d'),
            time:  deal.cleaned_at.strftime('%H:%M'),
            car_brand: deal.car&.car_model&.car_brand&.cn_name
          }
        end
      end

      records
    end

end
