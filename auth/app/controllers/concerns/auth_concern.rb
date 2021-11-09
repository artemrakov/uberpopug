# frozen_string_literal: true

module AuthConcern
  def sign_in(account)
    session[:account_id] = account.id
  end

  def sign_out
    session.delete(:account_id)
    session.clear
  end

  def signed_in?
    !current_account.guest?
  end

  def current_account
    @current_account ||= Account.find_by(id: session[:account_id]) || Guest.new
  end

  def authenticate_account!
    return if signed_in?

    redirect_to new_session_path
  end
end
