class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :destroy_session
  # before_action :doorkeeper_authorize!

  def destroy_session
    # make application not to send "Set-Cookie header"
    request.session_options[:skip] = true
  end
end
