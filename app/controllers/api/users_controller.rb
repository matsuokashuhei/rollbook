# frozen_string_literal: true

module API
  class UsersController < API::ApplicationController
    before_action :set_user, only: [:show, :update]

    def index
      users = User.active.all.order(:id)
      render json: users
    end

    def show
      render json: @user
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

    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        errors = @user.errors.full_messages.map { |message|
          { message: message }
        }
        render json: { errors: errors }, status: :unprocessable_entity
      end
   end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :school_id, :role, :status)
    end
  end
end
