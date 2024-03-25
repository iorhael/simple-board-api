# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefreshToken do
  subject(:refresh_token) { build(:refresh_token) }

  context 'when valid factory' do
    it { expect(refresh_token).to be_valid }
  end

  describe 'default values' do
    subject(:refresh_token) { create(:refresh_token) }

    describe 'default is_revoked' do
      subject(:status) { refresh_token.is_revoked? }

      it { is_expected.to be false }
    end

    describe 'default is_blacklisted' do
      subject(:status) { refresh_token.is_blacklisted? }

      it { is_expected.to be false }
    end
  end

  describe 'traits' do
    describe 'revoked' do
      let(:refresh_token) { build(:refresh_token, :revoked) }

      it { expect(refresh_token.is_revoked?).to be true }
    end

    describe 'blacklisted' do
      let(:refresh_token) { build(:refresh_token, :blacklisted) }

      it { expect(refresh_token.is_blacklisted?).to be true }
    end
  end
end
