class Api::V1::UsersController <  ActionController::API

  def show
    render json: {
      success: false,
      message: "Token为空，请退出后重新登陆"
    } and return unless params[:user_token].present?

    user = User.find_by_authentication_token(params[:user_token])
    render json: { success: false,
                   message: '该用户不存在'
    } and return unless user

    render json: {
      success: false,
      message: '账户停用，如有疑问请与客服联系',
    } and return if user.blacklist?

    render(json: UserSerializer.new(user).to_json)
  end

  def new
    @user = User.new
  end

  def send_pin
    mobile = params[:user][:mobile]
    @user = User.find_by(mobile: mobile)
    @user ||= User.create(mobile: mobile,
                          email: "#{mobile}@139.com",
                          password: Devise.friendly_token)
    @user.send_pin
    pin = $redis.get(mobile)
    puts pin
    render json: { success: true, pin: pin }
  #rescue Exception => e
  #  render json: { success: false, massenge: e.message }
  end

  def create
    @user = User.find_by(mobile: params[:mobile])
    render json: {success: false} and return unless @user

    password = params[:password]
    if @user.update_attributes(password: password, password_confirmation: password)
      render json: {
        authentication_token: @user.authentication_token,
        member: @user.member?
      }
    else
      render json: {success: false}
    end
  end

  def verify
    @user = User.find_by(mobile: params[:mobile])
    render json: { success: false, message: '用户不存在' } unless @user

    if $redis.get(@user.mobile) == params[:pin]
      render json: {success: true}
    else
      render json: {success: false}
    end
  rescue Exception => e
    render json: {success: false, message: e.message}
  end

  def update
    @user = User.find_by_authentication_token(params[:user_token])
    if @user.update user_params
      render json: @user
    else
      render json: {success: false, message: @user.errors.message }
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :avatar, :user_token)
  end
end
