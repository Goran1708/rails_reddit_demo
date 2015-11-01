class Api::V1::ApiController < RocketPants::Base
  
  version 1
  
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :authenticate

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end
  
    def authenticate_token
      #authenticate_with_http_token do |t, options|
       # User.find_by(token: t)
      #end
      User.find_by(token: params[:token])
    end
  
    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      expose 'Bad credentials', status: 401
    end

end