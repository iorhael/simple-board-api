# frozen_string_literal: true

module JwtAuthentication
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def self.issue_token(payload, expiration)
    payload[:exp] = expiration
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode_token(token)
    JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end
end
