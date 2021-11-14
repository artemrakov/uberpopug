class AccountsStreamConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      send(payload['event_name'].underscore, payload['data'])
    end
  end

  def account_created(data)
    Account.create!(
      public_id: data['public_id'],
      email: data['email'],
      role: data['role'],
      full_name: data['full_name']
    )
  end

  def account_updated(data)
    Account.transaction do
      account = Account.find_by(public_id: data['public_id'])
      account.update!(
        email: data['email'],
        full_name: data['full_name']
      )
    end
  end

  def account_deleted(data)
    Account.transaction do
      account = Account.find_by(public_id: data['public_id'])
      account.destroy!
    end
  end
end
