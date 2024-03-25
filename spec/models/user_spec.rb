# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user) }

  context 'when valid factory' do
    it { expect(user).to be_valid }
  end

  describe 'validations' do
    it { expect(user).to validate_presence_of :name }
    it { expect(user).to validate_presence_of :email }
    it { expect(user).to validate_presence_of :password }

    describe 'uniqueness validation' do
      subject(:user) { create(:user) }

      it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe 'email is not valid' do
    context 'when email is not a string' do
      let(:user) { build(:user, email: 1234) }

      it { expect(user).not_to be_valid }
    end

    context 'when email is invalid without @ symbol' do
      let(:user) { build(:user, email: 'testexample.com') }

      it { expect(user).not_to be_valid }
    end
  end

  describe 'email is valid' do
    context 'when email is a string with @ symbol' do
      let(:user) { build(:user, email: 'test@example.com') }

      it { expect(user).to be_valid }
    end
  end

  describe 'default values' do
    subject(:user) { create(:user) }

    describe 'default is_admin' do
      subject(:status) { user.is_admin? }

      it { is_expected.to be false }
    end

    describe 'default notification_method' do
      subject(:notification_method) { user.notification_method }

      it { is_expected.to eq('email') }
    end
  end

  describe 'traits' do
    describe 'admin' do
      let(:user) { build(:user, :admin) }

      it { expect(user.is_admin?).to be true }
    end

    describe 'notify_via_telegram' do
      let(:user) { build(:user, :notify_via_telegram) }

      it { expect(user.notification_method).to eq('telegram') }
    end
  end

  describe 'associations' do
    it { expect(user).to have_many(:refresh_tokens).dependent(:delete_all) }
  end
end
