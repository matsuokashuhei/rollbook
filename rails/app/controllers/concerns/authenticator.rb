# frozen_string_literal: true

module Authenticator
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def authenticate_token
    authenticate_with_http_token do |_token, _|
      if _token.blank?
        unauthorized(error: StandardError.new('token is blank.'))
        return
      end
      token = Cognito::AccessToken.new(_token)
      if token.valid?
        @token = token
      else
        # raise ActionController::InvalidAuthenticityToken
        unauthorized(error: StandardError.new('token is invalid.'))
      end
    end
  end

  def authenticate_user
    if @token.blank?
      unauthorized(error: StandardError.new('token is blank.'))
      return
    end
    @current_user = UserAuthentication.cognito.find_by(sub: @token.username)&.user
    if @current_user.blank?
      unauthorized(error: StandardError.new('user does not found.'))
      return
    end
  end
end
