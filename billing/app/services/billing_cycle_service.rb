class BillingCycleService
  class << self
    def close(billing_cycle)
      account = billing_cycle.account
      amount_hash = billing_cycle.billing_transactions.each_with_object({ credit: 0, debit: 0 }) do |transaction, acc|
        key = transaction.credit? ? :credit : :debit
        acc[key] += transaction.amount
      end

      net = amount_hash[:debit] - amount_hash[:credit]
      billing_cycle.close!

      closed_event = BillingCycle.new.closed(billing_cycle)
      EventSender.serve!(event: closed_event, type: 'billing_cycles.closed', topics: 'billing-cycle-lifecycle')

      return if net.negative? # do i need to do something about this ?

      # why do we need this payment ???
      payment_transaction = Transaction::Payment.create!(
        amount: net,
        billing_cycle: billing_cycle,
        account: account,
        accounting_entry: 'credit',
        data: {
          description: "Payment to user account #{account.email}"
        }
      )

      payment_event = Transaction.new.payment(payment_transaction)
      EventSender.serve!(event: payment_event, type: 'transitions.payment', topics: 'transitions')
    end
  end
end
