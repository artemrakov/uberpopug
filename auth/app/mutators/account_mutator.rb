class AccountMutator
  class << self
    def create(params)
      account = Account::SignUpForm.new(params)

      if account.save
        event = {
          **account_event_data,
          event_name: 'AccountCreated',
          data: {
            public_id: account.public_id,
            email: account.email,
            full_name: account.full_name,
            role: account.role,
            position: account.position
          }
        }

        send_event(event: event, type: 'accounts.created', version: 1, topic: 'accounts-stream')
      end

      account
    end

    def update(account, params)
      account.assign_attributes(params)

      return false unless account.valid?

      account.save

      event = {
        **account_event_data,
        event_name: 'AccountUpdated',
        data: {
          public_id: account.public_id,
          email: account.email,
          full_name: account.full_name,
          position: account.position
        }
      }
      send_event(event: event, type: 'accounts.updated', version: 1, topic: 'accounts-stream')

      account
    end

    def set_role(account, role)
      account.assign_attributes(role: role)

      return false unless account.valid?

      account.save
      event = {
        **account_event_data,
        event_name: 'AccountRoleChanged',
        data: {
          public_id: account.public_id,
          role: account.role
        }
      }

      send_event(event: event, type: 'accounts.role_changed', version: 1, topic: 'accounts')

      account
    end

    def destroy(account)
      account.mark_as_removed!

      event = {
        **account_event_data,
        event_name: 'AccountDeleted',
        data: { public_id: account.public_id }
      }

      send_event(event: event, type: 'accounts.deleted', version: 1, topic: 'accounts-stream')

      account
    end

    def account_event_data
      {
        event_id: SecureRandom.uuid,
        event_version: 1,
        event_time: Time.zone.now.to_s,
        producer: 'auth_service'
      }
    end

    def send_event(event:, type:, version:, topic:)
      result = SchemaRegistry.validate_event(event, type, version: version)

      if result.success?
        WaterDrop::SyncProducer.call(event.to_json, topic: topic)
      else
        raise result
      end
    end
  end
end
