# frozen_string_literal: true

module Cognito
  class CreateUser < ApplicationInteractor
    def call
      user = Cognito::User.sign_up!(user_params)
      context.cognito_user = user
    rescue StandardError => e
      handle_errors(e)
    end

    def rollback
      context.cognito_user.delete!
    end

    private

    def user_params
      params = context.user_params.to_h.with_indifferent_access
      {
        username: params[:email],
        password: 'from1996'
      }
    end

    def handle_errors(e)
      if e.is_a?(ArgumentError)
        attribute = if e.message.downcase.include?('username')
                      'aws.cognito.attributes.user.email'
                    elsif e.message.include?('password')
                      'aws.cognito.attributes.user.password'
                    else
                      raise e
                    end
        message = I18n.t('errors.format',
                         attribute: I18n.t(attribute),
                         message: I18n.t('errors.messages.blank'))
        context.fail!(errors: [{ message: message }])
        return
      end
      if e.is_a?(Aws::CognitoIdentityProvider::Errors::InvalidParameterException)
        attribute = if e.message.downcase.include?('username')
                      'aws.cognito.attributes.user.email'
                    elsif e.message.downcase.include?('phone')
                      'aws.cognito.attributes.user.phone'
                    else
                      raise e
                    end
        message = I18n.t('errors.format',
                         attribute: I18n.t(attribute),
                         message: I18n.t('errors.messages.invalid'))
        context.fail!(errors: [{ message: message }])
        return
      end
      if e.is_a?(Aws::CognitoIdentityProvider::Errors::UsernameExistsException)
        message = I18n.t('aws.cognito.errors.messages.username_exists')
        context.fail!(errors: [{ message: message }])
        return
      end
      if e.is_a?(Aws::CognitoIdentityProvider::Errors::InvalidPasswordException)
        message = I18n.t('aws.cognito.errors.messages.invalid_password')
        context.fail!(errors: [{ message: message }])
        return
      end
      raise e
    end
  end
end
