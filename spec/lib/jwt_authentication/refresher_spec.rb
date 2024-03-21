# frozen_string_literal: true

require 'spec_helper'
require 'jwt_authentication/refresher'

module JwtAuthentication
  RSpec.describe Refresher do
    let(:user) { create(:user) }

    describe '::call' do
      context 'when token with wrong type' do
        subject(:returned_data) { described_class.call(access_token) }
        let(:access_token) { JwtAuthentication::Encoder.call(user.id, 'access') }

        it 'return nil' do
          expect(returned_data).to be_nil
        end
      end

      context 'when token is blacklisted' do
        subject(:returned_data) { described_class.call(recieved_token) }
        let(:recieved_token) { JwtAuthentication::Encoder.call(user.id, 'refresh') }
        let(:db_token) { create(:refresh_token, :blacklisted, user:) }

        it 'return nil' do
          expect(returned_data).to be_nil
        end
      end
    end
  end
end
