# frozen_string_literal: true

module JwtAuthentication
  module Secret
    def self.secret_key
      ENV.fetch('JWT_SECRET_KEY')
    end
  end
end
