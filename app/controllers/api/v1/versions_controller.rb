class Api::V1::VersionsController < ApplicationController
  respond_to :json

  def show
    os   = params[:os].to_sym   == :ios ? :ios : :android
    kind = params[:kind].to_sym == :shop ? :shop : :car_owner
    send "#{os}_#{kind}_version"
  end

  private

    def ios_car_owner_version
      render json: {
        currentVersion: '2.0.4',
        packageSize: '26M',
        updateContent: ["1. Bug修复。", "2. 完善用户活动版块。"]
      }
    end

    def android_car_owner_version
      render json: {
        currentVersion: '2.0.4',
        packageSize: '25M',
        updateContent: ["1. Bug修复。", "2. 完善用户活动版块。"],
        download_url: 'https://www.autoxss.com/apk/xishuashua.apk'
      }
    end

    def ios_shop_version
      render json: {
        currentVersion: '2.0.7',
        packageSize: '12M',
        updateContent: ["1. 增加版本更新提示功能。", "2. 添加扫描二维码动画效果。", "3. 其他部分功能优化。"]
      }
    end

    def android_shop_version
      render json: {
        currentVersion: '2.0.7',
        packageSize: '12.6M',
        updateContent: ["1. 增加版本更新提示功能。", "2. 添加扫描二维码动画效果。", "3. 其他部分功能优化。"],
        download_url: 'https://www.autoxss.com/apk/xishuashua_shop.apk'
      }
    end
end
