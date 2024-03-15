# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  post '/auth/sign_in', to: 'sessions#create'
  post '/auth/refresh', to: 'sessions#refresh'
  post '/auth/logout', to: 'sessions#destroy'
  get '/auth/logout_all', to: 'sessions#destroy_all'
  post '/users/new', to: 'users#create'
  get '/users/profile', to: 'users#show'
  put '/users/update', to: 'users#update'
  delete '/users/delete', to: 'users#destroy'
end
