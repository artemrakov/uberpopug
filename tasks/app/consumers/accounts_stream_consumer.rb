class AccountsStreamConsumer < ApplicationConsumer
  def consume
    params_batch.each do |message|
      puts '-' * 80
      p message
      puts '-' * 80

      send(message.payload['event_name'].underscore, message.payload['data'])
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
    account = Account.find_by(public_id: data['public_id'])
    account.update!(
      email: data['email'],
      full_name: data['full_name']
    )
  end

  def account_deleted(data)
    account = Account.find_by(public_id: data['public_id'])
    account.destroy!
  end
end
