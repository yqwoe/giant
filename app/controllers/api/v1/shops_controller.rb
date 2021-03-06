class Api::V1::ShopsController < ApplicationController
  def search
    if params[:timestamp].present?
      render json: [] and return if server_version <= app_version
    end
    @q = Shop.ransack(name_cont:  params[:q], county_cont: params[:county], city_cont: params[:city])
    @shops = @q.result(distinct: true)
    render json: @shops
  end

  def current
    @current_user = User.find_by_authentication_token params[:user_token]
    @shop = nil
    @shop = @current_user.try(:shops).first if @current_user.present?
    render json: @shop
  end


  def show
    @shop = Shop.find(params[:id])
    render json: @shop
  end

  def list
    render json: {
      success: false,
      message: '参数不完整'
    } and return unless params[:lat].present? && params[:lng].present?

    lat = params[:lat]
    lng = params[:lng]
    @shops = Shop.within_radius(2000, lat, lng)
                 .order_by_distance(lat, lng)

    if @shops.length < 1
      @shops = Shop.where(name: '辉辉的洗车行') # 测试使用
    end

    render json: @shops
  end

  def counties
    @q = Shop.ransack(city_cont: params[:city])
    render json: @q.result(distinct: true).pluck(:county).reject {|c| c.nil? }
  end

  def index
    @shops = Shop.all unless params[:sort_by].present?
    case params[:sort_by]
    when 'default'
      @shops = Shop.all
    when 'latest'
      #TODO：这里需要使用真实算法
      @shops = Shop.all.order(id: :desc)
    when 'comment'
      @shops = Shop.all.order(star: :desc)
    end

    render json: @shops
  end

  private

  def server_version
    DateTime.parse '201706101915' # User UTC time
  end

  def app_version
    DateTime.parse params[:timestamp]
  rescue
    1.year.ago
  end
end
