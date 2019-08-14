# frozen_string_literal: true

module Cognito
  class AccessToken
    include ActiveModel::Model

    USER_POOL_ID = ENV['AWS_COGNITO_USER_POOL_ID']
    ISSUER_URL = "https://cognito-idp.#{ENV['AWS_REGION']}.amazonaws.com/#{USER_POOL_ID}"
    JWK_URL = "https://cognito-idp.#{ENV['AWS_REGION']}.amazonaws.com/#{USER_POOL_ID}/.well-known/jwks.json"

    attr_accessor :kid, :alg, :sub, :token_use, :scope, :auth_time, :iss, :exp, :iat, :version, :jti, :client_id, :username

    def initialize(token)
      @errors = ActiveModel::Errors.new(self)
      @token = token
      decoded_token = JWT.decode(@token, nil, false)
      header = decoded_token.find { |param| param.key?('kid') }
      %w[alg kid].each do |name|
        send("#{name}=", header[name])
      end
      payload = decoded_token.reject { |param| param.key?('kid') }.first
      %w[sub token_use scope auth_time iss exp iat version jti client_id username].each do |name|
        send("#{name}=", payload[name])
      end
    end

    validates :kid, :alg, :sub, :token_use, :scope, :auth_time, :iss, :exp, :iat, :username, presence: true
    # validates :alg, inclusion: { in: ['RS256'] }
    validate :match_signatures

    def match_signatures
      return if errors.present?
      return if (ENV['DEVELOPMENT_COGNITO_AUTHORIZATION'] || 'ON') == 'OFF'

      key = public_key
      options = {
        algorithm: @alg,
        iss: ISSUER_URL,
        iat: @iat,
        exp: @exp
      }
      JWT.decode(@token, key, true, options)
    rescue StandardError => e
      errors.add(:base, '')
    end

    private

    def openssl_bn(n)
      n += '=' * (4 - n.size % 4) if n.size % 4 != 0
      decoded = Base64.urlsafe_decode64(n)
      unpacked = decoded.unpack1('H*')
      OpenSSL::BN.new(unpacked, 16)
    end

    def public_key
      json_web_key = json_web_keys.yield_self do |keys|
        keys['keys'].find { |key| key['kid'] == @kid }
      end
      # web_keys = json_web_keys
      # web_key = web_keys['keys'].find { |key| key['kid'] == @kid }
      modulus = openssl_bn(json_web_key['n'])
      exponent = openssl_bn(json_web_key['e'])
      sequence = OpenSSL::ASN1::Sequence.new(
        [OpenSSL::ASN1::Integer.new(modulus), OpenSSL::ASN1::Integer.new(exponent)]
      )
      OpenSSL::PKey::RSA.new(sequence.to_der)
    end

    def json_web_keys
      response = Net::HTTP.get(URI.parse(JWK_URL))
      JSON.parse(response)
    end
  end
end
