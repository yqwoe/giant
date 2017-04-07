class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard'

  private

  def authenticate_admin!
    authenticate_user!
    render plain: 'illegal users' unless current_user.admin? || current_user.dadi?
  end

end
