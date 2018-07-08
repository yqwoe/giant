require 'aliyun/oss'
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

  def create
    @shop = Shop.new(set_shop_params)
    # binding.pry
    @shop.image = upload_image
    @shop.build_user({
                           email: "#{@shop.phone}@qq.com",
                           mobile: @shop.phone,
                           name: @shop.name,
                           password: "123456",
                           password_confirmation: "123456"
                       })
    respond_to do |format|
      if @shop.save!

        format.html { redirect_to admin_shops_path }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @shop = Shop.new(set_shop_params)
    # binding.pry
    @shop.image = upload_image
    respond_to do |format|
      if @shop.update!(set_shop_params)

        format.html { redirect_to admin_shops_path }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
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

  def set_shop_params
    params.require(:shop).permit(:name,:phone,:city,:star,:category,:address,:province,:county,:openning,:position=>[])
  end

  def upload_image
    endpoint = if Rails.env.development?
                 'https://oss-cn-beijing.aliyuncs.com'
               else
                 'https://oss-cn-beijing-internal.aliyuncs.com'
               end
    images = params[:shop][:detail_images] || nil
    # binding.pry
    return nil if images.blank?
    file = images.tempfile
    name = "#{Time.now.to_i}-#{images.original_filename}"
    # binding.pry
    client = ::Aliyun::OSS::Client.new(
        :endpoint => endpoint,
        :access_key_id => 'LTAIWfHhwayJt5iB',
        :access_key_secret => 'oF2DYkVe7uofbsQSuZ0YtD85lme0IQ')
    bucket = client.get_bucket("autoxss-assets-bucket")
    path  =file.path
    bucket.put_object("images/shops/#{name}",file: path)
    objects = bucket.list_objects(prefix: 'images/shops/test', :delimiter => '/')
    objects.each do |i|
      if i.is_a?(Aliyun::OSS::Object) # a object
        puts "object: #{i.key}"
      else
        puts "common prefix: #{i}"
      end
    end
    return name
  end

end
