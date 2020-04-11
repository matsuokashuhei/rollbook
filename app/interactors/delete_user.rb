# frozen_string_literal: true

class DeleteUser < ApplicationInteractor
  def call
    context.user.inactive!
  end
end
