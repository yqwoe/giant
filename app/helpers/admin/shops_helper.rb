module Admin::ShopsHelper
  def btn_active state
    state ? 'btn-success' : 'btn-default'
  end


  def shop_path(*args)
    puts args[0].id
    @shop.id.present? ? admin_shops_path(args[0].id) : admin_shops_path
  end
end
