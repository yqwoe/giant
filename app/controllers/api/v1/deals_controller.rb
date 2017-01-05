class Api::V1::DealsController <  Api::V1::BaseController
  def index
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

    render json: { record: records }
  end

  def show
    current_user.deals.find params[:id]
  end
end
