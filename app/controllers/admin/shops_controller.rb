class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: [
    :edit, :update, :destroy, :inactive, :active, :pending]

  def index
    @shops =
      Shop.with_deleted.order(created_at: :desc).paginate(page: params[:page])
  end

  def active
    @shop.restore
    @shop.actived!
    respond_to do |format|
      format.js
    end
  end

  def inactive
    @shop.inactived!
    respond_to do |format|
      format.js
    end
  end

  def pending
    @shop.pending!
    @shop.delete
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def destroy
    @shop.pending!
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
