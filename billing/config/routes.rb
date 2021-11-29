Rails.application.routes.draw do
  root 'transactions#index'

  resource :session, only: %i[new destroy]
  post 'auth/:provider', to: 'auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
end
