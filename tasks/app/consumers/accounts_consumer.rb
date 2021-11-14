class AccountsConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      send(payload['event_name'].underscore, payload['data'])
    end
  end

  def account_role_changed(data)
    Account.transaction do
      account = Account.find_by(public_id: data['public_id'])
      account.update!(role: data['role'])
    end
  end
end
