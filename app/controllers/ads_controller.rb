class AdsController < ApplicationController
  def show
    @user_name = params[:user_name]
    @user_img = params[:user_img]
  end

  def create
    uploader = AvatarUploader.new
    uploader.store!(params[:image])
    byebug
    uploader.retrieve_from_store!(params[:image])
  end

end
