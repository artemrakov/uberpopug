# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  root 'accounts#index'
  resources :accounts, only: [:new, :create]
end
