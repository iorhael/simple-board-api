# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render json: { data: 'Welcome to Simple board!' }
  end
end
