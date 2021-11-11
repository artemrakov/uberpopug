class AuthController < ApplicationController
  def callback
    account = Sso.authenticate_account(auth)
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
