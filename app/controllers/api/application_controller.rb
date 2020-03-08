# frozen_string_literal: true

module API
  class ApplicationController < ActionController::API
    include API::Authenticatable

    before_action :authenticate_token
    before_action :authenticate_user

    rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    attr_accessor :current_user

    protected

    def unauthorized(e = nil)
      handle_error(e)
      render json: { errors: [message: 'unauthorize'] }, status: :unauthorized
    end

    def not_found(e)
      handle_error(e)
      render status: :not_found
    end

    def unprocessable_entity(e)
      handle_error(e)
      render status: :unprocessable_entity
    end

    def internal_server_error(e)
      handle_error(e)
      render status: :internal_server_error
    end

    private

    def handle_error(e)
      logger.error(e)
      logger.error(e&.backtrace)
    end
  end
end
