class TransactionsConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      data = payload['data']

      case payload['event_name']
      when 'TransactionPayment'
        ActiveRecord::Base.transaction do
          billing_cycle = BillingCycle.find_by!(public_id: data['billing_cycle_public_id'])
          transaction = Transaction::Payment.find_by!(public_id: data['transaction_public_id'])
          account = Account.find_by!(public_id: data['account_public_id'])
          payment = Payment.create!(
            amount: data['amount'],
            transaction: transaction,
            billing_cycle: billing_cycle,
            account: account
          )

          # call payment provider

          payment.complete!
        end
      else
        # store in db
      end
    end
  end
end
