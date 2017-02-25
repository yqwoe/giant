class AdsController < ApplicationController
    protect_from_forgery prepend: true, with: :exception
  def show
    @user_name = params[:user_name]
    @user_img = params[:user_img]
  end

  def create

  end

end
