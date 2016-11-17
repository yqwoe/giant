class Api::V1::AuthController < ApplicationController
  def new
    @user = User.new
  end
end
