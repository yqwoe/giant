class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update]
  layout 'dashboard'

  def index
    @users = User.member.paginate(:page => params[:page])
  end

  def show
  end

  def search
    @users = User.find_by(mobile: params[:mobile])
    render :index
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
      @user = User.find params[:id]
      @cars = @user.cars if @user.member?
    end

    def user_params
      params.fetch(:user, {})
    end
end