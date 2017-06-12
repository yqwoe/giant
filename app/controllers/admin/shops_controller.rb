class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: [:edit, :update, :destroy]

  def index
    @shops = Shop.with_deleted.order(created_at: :desc).paginate(page: params[:page])
  end

  def update
    @shop.restore
  end

  def edit
  end

  def destroy
    if @shop.delete
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def set_shop
    @shop = Shop.with_deleted.find params[:id]
  end

end
