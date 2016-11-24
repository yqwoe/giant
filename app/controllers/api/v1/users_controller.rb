class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find_by_authentication_token(params[:user_token])
    render(json: UserSerializer.new(user).to_json)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(mobile: params[:user][:mobile])
    @user.generate_pin
    @user.send_pin
    respond_to do |format|
      format.js { render json: {mobile: @user.mobile} }
    end
  end

  def verify
    @user = User.find_by(user: params[:hidden_mobile])
    @user.verify(params[:pin])
    respond_to do |format|
      format.js
     end
  end

end
