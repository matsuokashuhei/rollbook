# frozen_string_literal: true

module Cognito
  extend ActiveSupport::Concern

  USER_POOL_ID ||= ENV['AWS_COGNITO_USER_POOL_ID']
  USER_POOL_CLIENT_ID ||= ENV['AWS_COGNITO_USER_POOL_CLIENT_ID']

  class_methods do
    def client
      @@client ||= configure_client
    end

    def configure_client
      Aws::CognitoIdentityProvider::Client.new(
        access_key_id: ENV['ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      )
    end
  end

  class User
    include Cognito

    attr_accessor :username, :email, :email_verified, :enabled, :user_status

    def initialize(username:, email:, email_verified: nil, enabled:, user_status:)
      @username = username
      @email = email
      @email_verified = email_verified
      @enabled = enabled
      @user_status = user_status
    end

    # https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Types/AdminGetUserResponse.html
    def self.initialize_from_admin_get_user_response(admin_get_user_response)
      new(
        username: admin_get_user_response.username,
        email: admin_get_user_response.user_attributes.find { |attribute| attribute.name == 'email' }.value,
        email_verified: admin_get_user_response.user_attributes.find { |attribute| attribute.name == 'email_verified' }&.value,
        enabled: admin_get_user_response.enabled,
        user_status: admin_get_user_response.user_status
      )
    end

    # @param [Aws::CognitoIdentityProvider::Types::UserType] user_type
    # https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Types/UserType.html
    def self.initialize_from_user_type(user_type)
      new(
        username: user_type.username,
        email: user_type.attributes.find { |attribute| attribute.name == 'email' }.value,
        email_verified: user_type.attributes.find { |attribute| attribute.name == 'email_verified' }&.value,
        enabled: user_type.enabled,
        user_status: user_type.user_status
      )
    end

    # https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#sign_up-instance_method
    def self.sign_up!(username:, password:)
      if username.blank?
        raise ArgumentError, 'missing required parameter :username'
      end
      if password.blank?
        raise ArgumentError, 'missing required parameter :password'
      end

      # raise ArgumentError, 'missing required parameter :phone' if phone.blank?

      params = {
        client_id: USER_POOL_CLIENT_ID,
        username: username,
        password: password,
        user_attributes: []
      }

      sign_up_respose = client.sign_up(params)
      get!(username: sign_up_respose.user_sub)
    end

    # Creates a new user
    #
    # @param [String] username
    # @return [Cognito::User]
    #
    # @see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#admin_create_user-instance_method
    def self.create!(username:, temporary_password:)
      params = { user_pool_id: USER_POOL_ID, username: username, temporary_password: temporary_password }
      if ENV['DEVELOPMENT_MAIL_SENDING'] || 'ON' == 'OFF'
        params.merge!(message_action: 'SUPPRESS')
      end
      admin_create_user_response = client.admin_create_user(params)
      get!(username: admin_create_user_response.user.username)
    end

    #
    # @param [String] username
    # @retrun [Cognito::User]
    #
    # @see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#admin_get_user-instance_method
    def self.get!(username:)
      params = { user_pool_id: USER_POOL_ID, username: username }
      admin_get_user_response = client.admin_get_user(params)
      initialize_from_admin_get_user_response(admin_get_user_response)
    end

    #
    # このメソッドは未使用です
    #
    # @see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#admin_delete_user-instance_method
    def self.delete!(username:)
      params = { user_pool_id: USER_POOL_ID, username: username }
      client.admin_delete_user(params)
    end

    #
    # このメソッドは未使用です
    #
    # @see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#admin_disable_user-instance_method
    def disabled!
      self.class.client.admin_disable_user(user_pool_id: USER_POOL_ID, username: @username)
    end

    #
    # このメソッドは未使用です
    #
    # @see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#admin_delete_user-instance_method
    def delete!
      self.class.client.admin_delete_user(user_pool_id: USER_POOL_ID, username: @username)
    end

    #
    # このメソッドは未使用です
    #
    # @see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/CognitoIdentityProvider/Client.html#admin_initiate_auth-instance_method
    def self.sign_in(email:, password:)
      client.admin_initiate_auth(
        user_pool_id: USER_POOL_ID,
        client_id: USER_POOL_CLIENT_ID,
        auth_flow: 'ADMIN_NO_SRP_AUTH',
        auth_parameters: {
          'USERNAME' => email,
          'PASSWORD' => password
        }
      )
    end
  end
end
