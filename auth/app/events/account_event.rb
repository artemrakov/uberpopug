class AccountEvent
  class << self
    def created(account)
      {
        event_name: 'AccountCreated',
        data: {
          public_id: account.public_id,
          email: account.email,
          full_name: account.full_name,
          role: account.role,
          position: account.position
        }
      }
    end

    def updated(account)
      {
        event_name: 'AccountUpdated',
        data: {
          public_id: account.public_id,
          email: account.email,
          full_name: account.full_name,
          position: account.position
        }
      }
    end

    def deleted(account)
      {
        event_name: 'AccountDeleted',
        data: { public_id: account.public_id }
      }
    end

    def role_changed(account)
      {
        event_name: 'AccountRoleChanged',
        data: {
          public_id: account.public_id,
          role: account.role
        }
      }
    end
  end
end
