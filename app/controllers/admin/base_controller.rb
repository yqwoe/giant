class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard'

  private

  def authenticate_admin!
    authenticate_user!
    redirect_to admin_url unless current_user.admin? || current_user.dadi?
  end

end
