class Api::V1::ShopsController < ApplicationController
  def search
    if params[:timestamp].present?
      render json: [] and return if server_version <= app_version
    end
    @q = Shop.ransack(name_cont:  params[:q], county_cont: params[:county], city_cont: params[:city])
    @shops = @q.result(distinct: true)
    render json: @shops
  end

  def show
    @shop = Shop.find(params[:id])
    render json: @shop
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
    DateTime.parse '201706011215' # User UTC time
  end

  def app_version
    DateTime.parse params[:timestamp]
  rescue
    1.year.ago
  end
end
