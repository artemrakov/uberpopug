class TransactionEvent < BaseEvent
  def charge(transaction)
    data = {
      amount: transaction.amount,
      billing_cycle_public_id: transaction.billing_cycle.public_id,
      account_public_id: transaction.account.public_id,
      task_public_id: transaction.task_public_id,
      description: transaction.description,
      transaction_public_id: transaction.public_id
    }

    build_event('TransactionCharge', data)
  end

  def payout(transaction)
    data = {
      amount: transaction.amount,
      billing_cycle_public_id: transaction.billing_cycle.public_id,
      account_public_id: transaction.account.public_id,
      task_public_id: transaction.task_public_id,
      description: transaction.description,
      transaction_public_id: transaction.public_id
    }

    build_event('TransactionPayout', data)
  end

  def payment(transaction)
    data = {
      amount: transaction.amount,
      billing_cycle_public_id: transaction.billing_cycle.public_id,
      account_public_id: transaction.account.public_id,
      description: transaction.description,
      transaction_public_id: transaction.public_id
    }

    build_event('TransactionPayment', data)
  end
end
