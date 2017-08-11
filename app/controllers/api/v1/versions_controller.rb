class Api::V1::VersionsController < ApplicationController
  before_action :set_version, only: [:show]
  respond_to :json

  def show
    render_version
  end

  def use_new_qrcode
    render json: { success: true}
  end

  private
    def set_version
      @version = case params[:kind].to_sym
                 when :shop
                   Version.shop.last
                 when :car_owner
                   Version.car_owner.last
                 else
                   Version.car_owner.last
                 end
    end

    def render_version
      render json: {
        currentVersion: @version.number,
        packageSize:    "#{@version.package_size.to_s}M",
        updateContent:  @version.contents,
        download_url:   @version.download_url
      }
    end
end
