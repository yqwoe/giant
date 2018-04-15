class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  
  layout 'dashboard'

  protected

  def authenticate_admin?
    render text: '请和管理员联系！' unless current_user.admin?
  end

  private

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?       ||
        current_user.dadi?           ||
        current_user.zhumadian_dadi? ||
        current_user.zhou?           ||
        current_user.luoyang_daili?
      render plain: 'illegal users'
    end
  end

end
