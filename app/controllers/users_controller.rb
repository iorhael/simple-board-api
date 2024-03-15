# frozen_string_literal: true

class UsersController < ApplicationController
  include Authentication

  before_action :authenticate_user, except: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def create
    user = User.create!(user_params)
    @token = JwtAuthentication.issue_token({ user_id: user.id }, Time.now.to_i + 10.minutes)
    render json: {
      token: @token
    }, status: :created
  end

  def profile
    render json: @user, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def handle_invalid_record(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity
  end
end
