# frozen_string_literal: true

module JwtAuthentication
  module Refresher
    class << self
      def call(refresh_token)
        decoded_token = JwtAuthentication::Decoder.call(refresh_token)

        return unless decoded_token && decoded_token['type'] == 'refresh' # raise exception?

        user = User.find(decoded_token['user_id'])
        token = user.refresh_tokens.find_by(jti: decoded_token['jti'])

        return if token.is_blacklisted? # raise exception?

        if token.is_revoked?
          destroy_sessions(token, user)
        else
          generate_new_pair(token, user)
        end
      end

      private

      def destroy_sessions(refresh_token, user)
        refresh_token.update(is_blacklisted: true)

        user.refresh_tokens.where(id: (refresh_token.id + 1)..).find_each do |token|
          token.update(is_revoked: true, is_blacklisted: true)
        end
      end

      def generate_new_pair(refresh_token, user)
        refresh_token.update(is_revoked: true)
        JwtAuthentication::PairGenerator.call(user)
      end
    end
  end
end
