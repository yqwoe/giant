class Api::V1::AuthenticateController <  ActionController::API
  def create
    resource = User.find_for_database_authentication(:login=>params[:login])
    render_unauthorized and return if resource.nil?

    render_not_match_app and return unless  match_app? resource, params[:client_kind]

    if resource.valid_password?(params[:password])
      render_valid resource and return
    else
      render_unauthorized
    end
  end

  private

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
    }
  end

  def match_app? resource, client_kind
    case client_kind
    when 'shop'
      resource.shop_owner?
    when client_kind == 'car'
      !resource.shop_owner?
    else
      false
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
