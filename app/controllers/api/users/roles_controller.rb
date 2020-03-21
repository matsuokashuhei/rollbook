# frozen_string_literal: true

module API
  module Users
    class RolesController < API::ApplicationController
      def index
        render json: User.roles.map { |k, v| { id: v, name: k } }.to_json
      end
    end
  end
end
