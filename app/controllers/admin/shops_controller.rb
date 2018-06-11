class Admin::ShopsController < Admin::BaseController
  autocomplete :car, :licensed_id, full: true

  before_action :authenticate_admin?

  before_action :set_shop, only: [
    :show, :edit, :update, :destroy, :inactive, :active, :pending]

  def index
    @shops = if current_user.admin?
               Shop.with_deleted
                   .order(created_at: :desc)
                   .paginate(page: params[:page])
             elsif current_user.luoyang_daili?
               Shop.with_deleted
                   .luoyang
                   .order(created_at: :desc)
                   .paginate(page: params[:page])
             end
  end

  def new
    @shop = Shop.new
  end

  def show
    @deals = @shop.deals
                  .includes(car: [:user])
                  .order(created_at: :desc)
                  .paginate(page: params[:page])
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
    @shop  = if current_user.admin?
               Shop.with_deleted.find params[:id]
             elsif current_user.luoyang_daili?
               Shop.with_deleted.luoyang.find params[:id]
             end
  end

end
