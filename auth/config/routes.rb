# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  root 'accounts#index'
  resources :accounts, only: %i[new create]
  get '/accounts/current', to: 'accounts#current'
  resource :session, only: %i[new create destroy]
end
