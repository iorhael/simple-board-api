# frozen_string_literal: true

require 'spec_helper'
require 'jwt_authentication/decoder'

module JwtAuthentication
  RSpec.describe Decoder do
    let(:payload) { { user_id: 1 } }

    describe '::call' do
      context 'when token signed with wrong key' do
        subject(:returned_data) { described_class.call(token) }
        let(:wrong_key) { OpenSSL::Random.random_bytes(12) }
        let(:token) { JWT.encode(payload, wrong_key) }

        it 'return nil' do
          expect(returned_data).to be_nil
        end
      end

      context 'when token signed with right key, but payload was changed' do
        subject(:returned_data) { described_class.call(fake_token) }
        let(:real_token) { JWT.encode(payload, JwtAuthentication::Secret.secret_key) }
        let(:fake_payload) { { fake_data: 123 } }
        let(:fake_token) { real_token.sub(/(?<=\.)[^.]+(?=\.)/, Base64URL.encode(fake_payload.to_json)) }

        it 'return nil' do
          expect(returned_data).to be_nil
        end
      end

      context 'when token signed with right key and payload was not changed' do
        subject(:returned_data) { described_class.call(real_token) }
        let(:real_token) { JWT.encode(payload, JwtAuthentication::Secret.secret_key) }

        it 'return correct payload' do
          expect(returned_data.symbolize_keys).to eql payload
        end
      end
    end
  end
end
