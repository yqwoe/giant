class Users::InvitationsController < ApplicationController
  # 临时使用，待正式上线后替换
  APP_PATH = 'http://a.app.qq.com/o/simple.jsp?pkgname=com.apicloud.A6982417590832'.freeze

  def index
  end

  def new
    cookies[:invitation_token] ||= params[:invitation_token]

    invitation_token = cookies[:invitation_token]
    @salesman = User.find_by_invitation_token(invitation_token)
    unless  @salesman
      render html: '<p>Are you kidding me?</p>'.html_safe, status: 500
    end
    @user = User.new
  end

  def create
    @user = User.find_by(mobile: params[:user][:mobile])
    if @user.verify(params[:user][:pin])
      @user.update_attributes(invited_by: params[:user][:invited_by])
      redirect_to APP_PATH
    else
      render :new
    end
  end

  def verify
    @user = Phone.find_by(phone: params[:hidden_phone])
    if @user.verify(params[:pin])
      respond_to do |format|
        format.js
      end
    end
  end
end
