class Admin::HomeController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard'

  private

  def authenticate_admin!
    authenticate_user!
    render plain: '非法用户！' unless current_user.admin?
  end
end
