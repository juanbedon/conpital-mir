class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def basic_auth
    authenticate_or_request_with_http_basic do |username, token|
      user = User.find_by_email(username)
      if user.auth_token == token
        sign_in user
      end
    end
  end

end