# frozen_string_literal: true

module API
  class UsersController < API::ApplicationController
    def index
      users = User.all.order(:id)
      render json: users
    end

    def create
      result = CreateUserOrganizer.call(user_params: user_params)
      if result.success?
        render json: result.user, status: :created
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    rescue StandardError => e
      internal_server_error(e)
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :school_id, :role, :status)
    end
  end
end
