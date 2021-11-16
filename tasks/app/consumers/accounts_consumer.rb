class AccountsConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      data = payload['data']

      case payload['event_name']
      when 'AccountRoleChanged'
        Account.transaction do
          account = Account.find_by(public_id: data['public_id'])
          account.update!(role: data['role'])
        end
      else
        # store in db
      end
    end
  end
end
