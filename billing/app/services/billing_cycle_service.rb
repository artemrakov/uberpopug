class BillingCycleService
  class << self
    def close(billing_cycle)
      account = billing_cycle.account
      amount_hash = billing_cycle.billing_transactions.each_with_object({ credit: 0, debit: 0 }) do |transaction, acc|
        key = transaction.credit? ? :credit : :debit
        acc[key] += transaction.amount
      end

      net = amount_hash[:debit] - amount_hash[:credit]
      p net

      if net.negative?
        can_not_close(billing_cycle, net)

        return
      end

      billing_cycle.close!
      # maybe send event Billing Cycle Closed
      return if net.zero?

      payment_transaction = Transaction::Payment.create!(
        amount: net,
        billing_cycle: billing_cycle,
        account: account,
        accounting_entry: 'credit',
        data: {
          description: "Payment to user account #{account.email}"
        }
      )
      account.update!(balance: 0)

      # event = {
      #   transaction_public_id: payment_transaction.public_id,
      #   billing_cycle_public_id: billing_cycle.public_id,
      #   account_public_id: account.public_id,
      #   amount: net
      # }
      # send event PaymentTransactionApplied, topic: 'payments' -> see PaymentsConsumer
    end

    def can_not_close(billing_cycle, amount)
      event = {
        billing_cycle_public_id: billing_cycle.public_id,
        amount: amount,
        account_public_id: account.public_id
      }
      # send event CannotCloseBillingCycle, topic: 'payments'
    end
  end
end
