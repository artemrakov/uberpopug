class Sso
  def self.authenticate_account(auth)
    account = Account.find_or_initialize_by(public_id: auth.info.public_id)
    account.update!(
      email: auth.info.email,
      full_name: auth.info.full_name,
      role: auth.info.role,
      public_id: auth.info.public_id
    )

    auth_identity = account.auth_identities.find_or_initialize_by(provider: auth.provider)
    auth_identity.update!(
      uid: auth.uid,
      token: auth.credentials.token,
      login: auth.info.email
    )

    account
  end
end
