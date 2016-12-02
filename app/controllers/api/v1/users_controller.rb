class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def show
    user = User.find_by_authentication_token(params[:user_token])
    render(json: UserSerializer.new(user).to_json)
  end

  def new
    @user = User.new
  end

  def send_pin
    @user = User.find_or_create_by(mobile: params[:user][:mobile])
    @user.send_pin
    render json: { success: true, pin: @user.pin }
  end

  def create
    @user = User.new(mobile: params[:user][:mobile], password: params[:user][:password])
    if @user.save
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
