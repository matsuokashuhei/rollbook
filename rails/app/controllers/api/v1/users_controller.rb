# frozen_string_literal: true

module API
  module V1
    class UsersController < ::API::ApplicationController
      def index
        users = User.active.all
        serializer = UserSerializer.new(users)
        render json: serializer.serialized_json
      end
    end
  end
end
