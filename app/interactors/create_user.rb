# frozen_string_literal: true

class CreateUser < ApplicationInteractor
  def call
    user = User.new(params)
    if user.valid?
      user.save!
      context.user = user
    else
      handle_errors(user.errors)
    end
  end

  private

  def params
    context
        .user_params
        .to_h
        .with_indifferent_access
        .slice(:name, :email)
        .merge(password: 'from1996')
        .merge(cognito_username: context.cognito_user.username)
  end
end
