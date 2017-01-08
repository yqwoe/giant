class Api::V1::ShopsController < ApplicationController
  def search
    @q = Shop.ransack(name_cont:  params[:q], county_cont: params[:county])
    @shops = @q.result(distinct: true).as_json
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
end
