class BillingCycleService
  class << self
    def close(billing_cycle)
      account = billing_cycle.account
      amount_hash = billing_cycle.billing_transactions.each_with_object({ credit: 0, debit: 0 }) do |transaction, acc|
        key = transaction.credit? ? :credit : :debit
        acc[key] += transaction.amount
      end

      net = amount_hash[:debit] - amount_hash[:credit]

      if net.negative?
        can_not_close(billing_cycle, net)

        cannot_close_event = BillingCycle.new.cannot_close(billing_cycle)
        EventSender.serve!(event: cannot_close_event, type: 'billing_cycles.cannot_close', topics: 'billing-cycle-lifecycle')

        return
      end

      billing_cycle.close!

      closed_event = BillingCycle.new.closed(billing_cycle)
      EventSender.serve!(event: closed_event, type: 'billing_cycles.closed', topics: 'billing-cycle-lifecycle')

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

      payment_event = Transaction.new.payment(payment_transaction)
      EventSender.serve!(event: payment_event, type: 'transitions.payment', topics: 'transitions')
    end
  end
end
