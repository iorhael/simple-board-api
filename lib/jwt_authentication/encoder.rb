# frozen_string_literal: true

module JwtAuthentication
  module Encoder
    def self.call(user_id, type)
      jti = SecureRandom.uuid
      exp = expiration_time(type)
      token = JWT.encode({ user_id:, jti:, type:, iat: Time.now.to_i, exp: }, JwtAuthentication::Secret.secret_key)

      [token, jti, exp]
    end

    def self.expiration_time(type)
      if type == 'access'
        10.minutes.from_now.to_i
      else
        3.days.from_now.to_i
      end
    end

    class << self
      private :expiration_time
    end
  end
end
