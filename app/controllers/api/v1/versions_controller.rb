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
        currentVersion: '2.2.0',
        packageSize: '28.3M',
        updateContent: ["1. 用Silentboy牌杀虫剂消灭一些影响用户体验的Bugs。",
                        "2. 增加了车行详情页面，用户可以海陆空全方面了解洗车行咯...",
                        "3. 开发了车行套餐购买的新功能，快修快保货比三家，妈妈再不说我乱花钱了 ：）",
                        "4. 增加了跨区域显示，现在会员可以浏览其他城市的洗车行了",
                        "PS: 营销中心正在加班加点为我们尊贵的会员争取福利，那些空白的车行详情页面，我们会很快上线的哦"],
        download_url: 'https://autoxss.com/system/xishuashua_2.2.0.apk'
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
