# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes' do
  describe 'GET index' do
    before { get '/' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'return correct json' do
      expect(response.body).to eq('{"data":"Welcome to Simple board!"}')
    end
  end
end
