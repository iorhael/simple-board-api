# frozen_string_literal: true

module JwtAuthentication
  module Encoder
    class << self
      def call(user_id, type)
        jti = SecureRandom.uuid
        exp = expiration_time(type)
        token = JWT.encode({ user_id:, jti:, type:, iat: Time.now.to_i, exp: }, JwtAuthentication::Secret.secret_key)

        [token, jti, exp]
      end

      private

      def expiration_time(type)
        if type == 'access'
          10.minutes.from_now.to_i
        else
          3.days.from_now.to_i
        end
      end
    end
  end
end
