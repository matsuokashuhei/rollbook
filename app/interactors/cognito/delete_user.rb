# frozen_string_literal: true

module Cognito
  class DeleteUser < ApplicationInteractor
    def call
      cognito_user.disabled!
    end

    private

    def cognito_user
      context.user.cognito_user
    end
  end
end
