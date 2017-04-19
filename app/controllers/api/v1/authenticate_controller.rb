class Api::V1::AuthenticateController <  ActionController::API
  def create
    resource = User.find_for_database_authentication(:login=>params[:login])
    render_unauthorized and return if resource.nil?
    render_not_match_app and return unless  match_app? resource, params[:client_kind]

    # check if device exist?
    if params[:device_id].present?
      device = Device.find_or_create_by uuid: params[:device_id].strip
      unless device.users.include? resource
        DevicesAndUsersRelationship.create device_id: device.id, user_id: resource.id
      end

      if device.users.count > 3
        render_too_many_accounts_sign_in_same_device and return
      end
    end
    # check resource loged in with this device
    # if not, check loged in acounts count,
    # if larger than 3, reject
    # else log in

    if resource.valid_password?(params[:password])
      render_valid resource and return
    else
      render_unauthorized
    end
  end

  private

  def render_too_many_accounts_sign_in_same_device
    render json: {
      success: false,
      message: "一台设备最多可以登陆三个账户, 请更换手机再次登录！",
    }, status: :unauthorized
  end

  def render_unauthorized
    render json:
      {
        success: false,
        message: "用户名或密码错误 ！"
      },
      status: :unauthorized
  end

  def render_valid resource
    render json: {
      login:      resource.login,
      email:      resource.email,
      member:     resource.member?,
      success:    true,
      auth_token: resource.authentication_token,
      role:       resource.role,
      authenticated_time: Time.zone.now.strftime('%Y-%m-%d %H:%M')
    }
  end

  def match_app? resource, client_kind
    case client_kind
    when 'shop'
      resource.shop_owner?
    when 'car'
      !resource.shop_owner?
    else
      true
    end
  rescue
    false
  end

  def render_not_match_app
    render json: {
      success: false,
      message: "用户与App不匹配。"
    }
  end
end
