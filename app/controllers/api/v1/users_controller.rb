class Api::V1::UsersController <  ActionController::API

  def show
    user = User.find_by_authentication_token(params[:user_token])
    if user
      render(json: UserSerializer.new(user).to_json) and return
    else
      render json: { success: false, message: '该用户不存在' }
    end
  end

  def new
    @user = User.new
  end

  def send_pin
    mobile = params[:user][:mobile]
    @user = User.find_by(mobile: mobile)
    @user ||= User.create(mobile: mobile, email: "#{mobile}@139.com", password: Devise.friendly_token)
    @user.send_pin
    render json: { success: true, pin: @user.pin }
  rescue Exception => e
    render json: { success: false, massenge: e.message }
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
    if @user.verify(params[:pin])
      render json: {success: true}
    else
      render json: {success: false}
    end
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
