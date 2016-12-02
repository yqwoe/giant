class Api::V1::UsersController <  ActionController::API

  def show
    user = User.find_by_authentication_token(params[:user_token])
    render(json: UserSerializer.new(user).to_json)
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
  end

  def create
    @user = User.find_by(mobile: params[:user][:mobile])
    password = params[:user][:password]
    if @user.update_attributes(password: password, password_confirmation: password)
      render json: {authentication_token: @user.authentication_token}
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

end
