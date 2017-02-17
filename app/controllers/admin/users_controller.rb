class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update]
  layout 'dashboard'

  def index
    @users = User.member.paginate(:page => params[:page])
    @users_count = @users.count
  end

  def show
  end

  def search
    @users = User.where('mobile like ?', "%#{params[:mobile]}%")
      .paginate(page: params[:page])
    render template: 'admin/users/index'
  end

  def edit
  end

  def update
    @user.name = user_params[:name]
    @user.mobile = user_params[:mobile]
    case user_params[:roles]
    when 'member'
      @user.member!
    when 'registed'
      @user.registed!
    end

    @user.save
    render :edit
  end

  private

    def set_user
      return if params[:id] == 'search'
      @user = User.find params[:id]
      @cars = @user.cars if @user.member?
    end

    def user_params
      params.fetch(:user, {})
    end
end
