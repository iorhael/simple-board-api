# frozen_string_literal: true

require 'spec_helper'
require 'jwt_authentication/pair_generator'

module JwtAuthentication
  RSpec.describe PairGenerator do
    let(:user) { create(:user) }

    describe '::call' do
      subject(:returned_data) { described_class.call(user) }

      it 'return two tokens' do
        expect(returned_data.size).to be 2
      end

      it 'write refresh token to database' do
        returned_data
        expect(user.refresh_tokens.size).to be 1
      end
    end
  end
end
