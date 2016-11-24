class Api::V1::AuthenticateController < Api::V1::BaseController
  skip_before_filter :authenticate_user_from_token!, :only => [:create ]

  def create
    resource = User.find_for_database_authentication(:login=>params[:user][:login])

    if resource.nil?
      render json: {
        success:  false,
        message: "用户名或密码错误 ！"
      }, status: :unauthorized
    end

    if resource.valid_password?(params[:user][:password])
      sign_in resource, store: false
      render json: {
        login:      resource.login,
        email:      resource.email,
        success:    true,
        auth_token: resource.authentication_token
      }
    else
      render json: {:success=>false,
                    :message=>"用户名或密码错误!"}, status: :unauthorized
    end
  end

end
