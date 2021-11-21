class AccountMutator
  class << self
    def create(params)
      account = Account::SignUpForm.new(params)

      if account.save
        event = StreamingAccountEvent.new.created(account)
        EventSender.serve!(event: event, type: 'accounts.created', version: 1, topic: 'accounts-stream')
      end

      account
    end

    def update(account, params)
      account.assign_attributes(params)

      return false unless account.valid?

      account.save!

      event = StreamingAccountEvent.new.updated(account)
      EventSender.serve!(event: event, type: 'accounts.updated', version: 1, topic: 'accounts-stream')

      account
    end

    def set_role(account, role)
      account.assign_attributes(role: role)

      return false unless account.valid?

      account.save!
      event = AccountEvent.new.role_changed(account)
      EventSender.serve!(event: event, type: 'accounts.role_changed', version: 1, topic: 'accounts')

      account
    end

    def destroy(account)
      account.mark_as_removed!

      event = StreamingAccountEvent.new.deleted(account)
      EventSender.serve!(event: event, type: 'accounts.deleted', version: 1, topic: 'accounts-stream')

      account
    end
  end
end
