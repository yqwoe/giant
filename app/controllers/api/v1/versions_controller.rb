class Api::V1::VersionsController < ApplicationController
  respond_to :json

  def show
    os   = params[:os].to_sym   == :ios ? :ios : :android
    kind = params[:kind].to_sym == :shop ? :shop : :car_owner
    send "#{os}_#{kind}_version"
  end

  def use_new_qrcode
    render json: { success: true}
  end

  private

    def ios_car_owner_version
      render json: {
        currentVersion: '2.1.0',
        packageSize: '26M',
        updateContent: ["1. Bug修复。", "2. 完善用户活动版块。"]
      }
    end

    def android_car_owner_version
      render json: {
        currentVersion: '2.3.0',
        packageSize: '29.8M',
        updateContent: ["1. 增加了联盟商家,会员可以在嘻唰唰联盟商家进行折扣消费。"],
        download_url: 'https://autoxss.com/system/xishuashua_2.3.0.apk'
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
        currentVersion: '2.2.3',
        packageSize: '13M',
        updateContent: ["1. 增加套餐营销记录。", "2. 添加套餐验证功能。", "3. 部分细节优化 。"],
        download_url: 'https://autoxss.com/system/xishuashua_shop_2.2.3.apk'
      }
    end
end
