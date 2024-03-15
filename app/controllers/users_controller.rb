# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.create!(user_params)
    access_token, refresh_token = JwtAuthentication::PairGenerator.call(user)
    render json: { access_token:, refresh_token: }, status: :created
  end

  def update
    if @user.authenticate(user_params[:password_confirmation])
      @user.update!(user_params)
      render json: { message: 'User successfully updated' }, status: :ok
    else
      render json: { error: "Password confirmation doesn't match the current password" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.authenticate(user_params[:password_confirmation])
      @user.destroy
      render json: { message: 'User successfully deleted' }, status: :ok
    else
      render json: { error: "Password confirmation doesn't match the current password" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :password_confirmation)
  end

  def handle_invalid_record(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_entity
  end
end
