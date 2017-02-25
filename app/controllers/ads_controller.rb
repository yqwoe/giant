class AdsController < ApplicationController
  protect_from_forgery prepend: true, with: :exception

  UPLOAD_IMAGE_DIR = 'uploads/ads/'.freeze

  def show
  end

  def create
    @uploader = AvatarUploader.new
    @uploader.store! ad_params[:avatar][0].tempfile
    redirect_to action: :show,
       name: ad_params[:name],
       img: get_image_name
  end

  private

  def ad_params
    params.require(:ad).permit(:name, avatar: [])
  end

  def get_image_name
    @uploader.url.split('/').last
  end
end
