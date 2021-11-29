class StreamingAccountEvent < BaseEvent
  def created(account)
    data = {
      public_id: account.public_id,
      email: account.email,
      full_name: account.full_name,
      role: account.role,
      position: account.position
    }

    build_event('AccountCreated', data)
  end

  def updated(account)
    data = {
      public_id: account.public_id,
      email: account.email,
      full_name: account.full_name,
      position: account.position
    }

    build_event('AccountUpdated', data)
  end

  def deleted(account)
    data = { public_id: account.public_id }

    build_event('AccountDeleted', data)
  end
end
