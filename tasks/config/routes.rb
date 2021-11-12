Rails.application.routes.draw do
  root 'tasks#index'
  resource :session, only: %i[new destroy]
  resources :tasks, only: %i[new create] do
    post :shuffle, on: :collection
  end
  post 'auth/:provider', to: 'auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
end
