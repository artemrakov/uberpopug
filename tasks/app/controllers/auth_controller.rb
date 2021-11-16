class AuthController < ApplicationController
  def callback
    account = Sso.authenticate_account(auth)

    if account.persisted?
      sign_in account
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
