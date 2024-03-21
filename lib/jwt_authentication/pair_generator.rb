# frozen_string_literal: true

module JwtAuthentication
  module PairGenerator
    def self.call(user)
      access_token = JwtAuthentication::Encoder.call(user.id, 'access').first
      refresh_token, jti, exp = JwtAuthentication::Encoder.call(user.id, 'refresh')

      user.refresh_tokens.create(jti:, expires_at: Time.zone.at(exp).to_datetime)

      [access_token, refresh_token]
    end
  end
end
