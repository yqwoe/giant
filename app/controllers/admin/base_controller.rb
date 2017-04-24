class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard'

  private

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin? || current_user.dadi? || current_user.zhumadian_dadi?
      render plain: 'illegal users'
    end
  end

end
