# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate_user
    return unless current_user.nil?

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  private

  def current_user
    token = request.headers['Authorization']
    decoded_token = JwtAuthentication::Decoder.call(token)

    return unless decoded_token && decoded_token['type'] == 'access'

    user_id = decoded_token['user_id']
    @user = User.find_by(id: user_id)
  end
end
