# frozen_string_literal: true

module API
  class ApplicationController < ActionController::API
    include Authenticator

    before_action :authenticate_token
    before_action :authenticate_user

    def unauthorized(error: nil)
      logger.error(error)
      render json: { message: error.message }, status: :unauthorized
    end

    def internal_server_error(error: nil)
      logger.error(error)
      render json: { message: error.message }, status: :internal_server_error
    end
  end
end
