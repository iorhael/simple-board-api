# frozen_string_literal: true

require 'spec_helper'
require 'jwt_authentication/encoder'

module JwtAuthentication
  RSpec.describe Encoder do
    let(:user_id) { 1 }
    let(:access_type) { 'access' }
    let(:refresh_type) { 'refresh' }

    describe '::call' do
      context 'with access type' do
        subject(:returned_data) { described_class.call(user_id, access_type) }
        let(:token_data) { JWT.decode(returned_data.first, JwtAuthentication::Secret.secret_key).first }

        it 'token contains correct user_id' do
          expect(token_data['user_id']).to eql user_id
        end

        it 'token contains correct type' do
          expect(token_data['type']).to eql access_type
        end

        it 'token will expire in 10 minutes' do
          expect(token_data['exp']).to eql 10.minutes.from_now.to_i
        end
      end

      context 'with refresh type' do
        subject(:returned_data) { described_class.call(user_id, refresh_type) }
        let(:token_data) { JWT.decode(returned_data.first, JwtAuthentication::Secret.secret_key).first }

        it 'token contains correct user_id' do
          expect(token_data['user_id']).to eql user_id
        end

        it 'token contains correct type' do
          expect(token_data['type']).to eql refresh_type
        end

        it 'token will expire in 3 days' do
          expect(token_data['exp']).to eql 3.days.from_now.to_i
        end
      end
    end
  end
end
