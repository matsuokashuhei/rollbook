# frozen_string_literal: true

module API
  class UsersController < API::ApplicationController
    def index
      users = User.all.order(:id)
      render json: users
    end
  end
end
