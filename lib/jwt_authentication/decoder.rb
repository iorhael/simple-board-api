# frozen_string_literal: true

module JwtAuthentication
  module Decoder
    def self.call(token)
      JWT.decode(token, JwtAuthentication::Secret.secret_key, true, algorithm: 'HS256').first
    rescue JWT::DecodeError
      nil
    end
  end
end
