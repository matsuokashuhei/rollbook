# frozen_string_literal: true

module API
  module Authenticatable
    extend ActiveSupport::Concern
    include ActionController::HttpAuthentication::Token::ControllerMethods

    protected

    def authenticate_token
      authenticate_with_http_token do |_token, _|
        if _token.blank?
          unauthorized
          return
        end
        token = Cognito::AccessToken.new(_token)
        if token.valid?
          @token = token
        else
          unauthorized
        end
      end
    end

    def authenticate_user
      if @token.blank?
        unauthorized
        return
      end
      @current_user = User.find_by(cognito_username: @token.username)
      if @current_user.blank?
        unauthorized
        return
      end
      @group = @current_user.group
    end
  end
end
