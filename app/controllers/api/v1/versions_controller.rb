class Api::V1::VersionsController < ApplicationController
  before_action :set_shop, only: [:show]
  respond_to :json

  def show
    send "#{os}_#{kind}_version"
  end

  def use_new_qrcode
    render json: { success: true}
  end

  private
    def set_version
      @version = case params[:kind]
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
        packageSize:    @version.package_size,
        updateContent:  @version.contents,
        download_url:   @version.download_url
      }
    end
end
