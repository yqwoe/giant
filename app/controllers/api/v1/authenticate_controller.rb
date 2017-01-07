class Api::V1::AuthenticateController <  ActionController::API
  def create
    resource = User.find_for_database_authentication(:login=>params[:login])

    if resource.nil?
      render json: {
        success:  false,
        message: "用户名或密码错误 ！"
      }, status: :unauthorized and return
    end

    if resource.valid_password?(params[:password])
      sign_in resource, store: false
      render json: {
        login:      resource.login,
        email:      resource.email,
        success:    true,
        auth_token: resource.authentication_token,
        member: resource.member?

      } and return
    else
      render json: {:success=>false,
                    :message=>"用户名或密码错误!"}, status: :unauthorized
    end
  end

end
