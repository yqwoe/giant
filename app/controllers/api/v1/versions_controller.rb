class Api::V1::VersionsController < ApplicationController
  def show
    render json: {
      currentVsersion: '2.0.3',
      packageSize: '26M',
      updateContent: ["1. Bug修复。", "2. 完善用户活动版块。"]
    }
  end
end
