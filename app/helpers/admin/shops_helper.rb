module Admin::ShopsHelper
  def btn_active state
    state ? 'btn-success' : 'btn-default'
  end
end
