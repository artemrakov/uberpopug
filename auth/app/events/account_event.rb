class AccountEvent < BaseEvent
  def role_changed(account)
    data = {
      public_id: account.public_id,
      role: account.role
    }

    build_event('AccountRoleChanged', data)
  end
end
