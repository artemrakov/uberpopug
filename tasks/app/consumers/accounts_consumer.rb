class AccountsConsumer < ApplicationConsumer
  def consume
    params_batch.each do |message|
      puts '-' * 80
      p message
      puts '-' * 80

      send(message.payload['event_name'].underscore, message.payload['data'])
    end
  end

  def account_role_changed(data)
    account = Account.find_by(public_id: data['public_id'])
    account.update!(role: data['role'])
  end
end
