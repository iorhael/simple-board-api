# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    def current_user
      token = request.headers['Authorization']
      decoded_token = JwtAuthentication.decode_token(token)

      return unless decoded_token

      user_id = decoded_token['user_id']
      @user = User.find_by(id: user_id)
    end

    def authenticate_user
      return unless current_user.nil?

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
