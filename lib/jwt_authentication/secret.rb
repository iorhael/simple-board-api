# frozen_string_literal: true

module JwtAuthentication
  module Secret
    def self.secret_key
      Rails.application.credentials.secret_key_base
    end
  end
end
