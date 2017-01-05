class Api::V1::BaseController < ActionController::API
  before_action :authenticate_user_from_token!
  before_action :destroy_session

  respond_to :josn

  def destroy_session
    # make application not to send "Set-Cookie header"
    request.session_options[:skip] = true
  end


  private

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    else
      render json: {success: false, message: 'Invalid token!'}, status: :unauthorized
    end
  end
end
