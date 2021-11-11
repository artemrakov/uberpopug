# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  root 'accounts#index'
  resources :accounts do
    put :set_role, on: :member
  end

  get '/account', to: 'credentials#account'
  resource :session, only: %i[new create destroy]
end
