class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_admin?

  layout 'dashboard'

  def index
    respond_to do |format|
      format.html do
        @users = User.member.paginate(:page => params[:page])
        @users_count = @users.count
      end

      format.xls do
        @cars = Car.all
        render layout: "application"
      end
    end
  end

  def show
  end

  def search
    @users = User.where('mobile like ?', "%#{params[:mobile]}%")
                 .paginate(page: params[:page])

    if @users.empty?
      cars = Car.where('licensed_id LIKE ?', "%#{params[:mobile].upcase}%")
      @users = User.where('id IN (?)', cars.pluck(:user_id))
        .paginate(page: params[:page]) if cars.exists?
    end

    if @users.exists?
      render template: 'admin/users/index' and return
    end

    if @users.empty?
      @shops = Shop.with_deleted
                   .where('name LIKE ?', "%#{params[:mobile]}%")
                   .paginate(page: params[:page])
    end

    render template: 'admin/shops/index' and return
  end

  def edit
  end

  def update
    @user.name = user_params[:name]
    @user.mobile = user_params[:mobile]
    case user_params[:role]
    when 'member'
      @user.member!
    when 'registed'
      @user.registed!
    when 'block'
      @user.blacklist!
    when 'shop_owner'
      @user.shop_owner!
    end

    @user.save
    render :edit
  end

  private

    def set_user
      return if params[:id] == 'search'
      @user = User.find params[:id]
      @cars = @user.cars
    end

    def user_params
      params.fetch(:user, {})
    end

    def authenticate_admin?
      render text: '请和管理员联系！' unless current_user.admin?
    end
end
