class Api::V1::VersionsController < ApplicationController
  respond_to :json

  swagger_controller :versions, 'Versions'

  swagger_api :show do
    summary 'return version'
    notes 'return version by platform and app kind'
  end

  def show
    send "#{params[:os]}_#{params[:kind]}_version"
  end

  def use_new_qrcode
    render json: { success: false }
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
