# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate_user, only: :destroy_all
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def create
    user = User.find_by!(email: login_params[:email])

    if user.authenticate(login_params[:password])
      access_token, refresh_token = JwtAuthentication::PairGenerator.call(user)
      render json: { user: UserSerializer.new(user), access_token:, refresh_token: }, status: :accepted
    else
      render json: { error: 'Invalid password' }, status: :unauthorized
    end
  end

  def refresh
    access_token, refresh_token = JwtAuthentication::Refresher.call(refresh_params)

    if access_token.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    else
      render json: { access_token:, refresh_token: }, status: :accepted
    end
  end

  def destroy
    decoded_token = JwtAuthentication::Decoder.call(refresh_params)

    return render json: { error: 'Not valid token' }, status: :unprocessable_entity if decoded_token.nil?

    user = User.find(decoded_token['user_id'])
    token = user.refresh_tokens.find_by(jti: decoded_token['jti'])

    if token.is_revoked?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    else
      token.update(is_revoked: true)
      render json: { message: 'Successfully log outed' }, status: :ok
    end
  end

  def destroy_all
    @user.refresh_tokens.find_each { |token| token.update(is_revoked: true) }
    render json: { message: 'Successfully log outed' }, status: :ok
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def refresh_params
    params.require(:refresh_token)
  end

  def handle_record_not_found
    render json: { message: "User doesn't exist" }, status: :unauthorized
  end
end
