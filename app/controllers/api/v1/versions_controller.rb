class Api::V1::VersionsController < ApplicationController
  def show
    send "#{params[:os]}_#{params[:kind]}_version"
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
        download_url: 'https://autoxss.com/apk/xishuashua.apk'
      }
    end

    def ios_shop_version
      render json: {
        currentVersion: '2.0.6',
        packageSize: '25M',
        updateContent: ["1. Bug修复。", "2. 完善用户活动版块。"]
      }
    end

    def android_shop_version
      render json: {
        currentVersion: '2.0.6',
        packageSize: '25M',
        updateContent: ["1. Bug修复。", "2. 完善用户活动版块。"],
        download_url: 'https://autoxss.com/apk/xishuashua.apk'
      }
    end
end
