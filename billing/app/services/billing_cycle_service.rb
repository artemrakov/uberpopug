class BillingCycleService
  class << self
    def close(billing_cycle)
      account = billing_cycle.account
      billing_cycle.close!
      amount = account.balance

      closed_event = BillingCycle.new.closed(billing_cycle)
      EventSender.serve!(event: closed_event, type: 'billing_cycles.closed', topics: 'billing-cycle-lifecycle')

      return if amount.negative?

      payment_transaction = Transaction::Payment.create!(
        amount: amount,
        billing_cycle: billing_cycle,
        account: account,
        accounting_entry: 'credit',
        data: {
          description: "Payment to user account #{account.email}"
        }
      )
      account.update!(balance: 0)

      payment = Payment.create!(
        amount: amount,
        billing_cycle: billing_cycle,
        transaction: payment_transaction,
        account: account
      )

      payment.waiting_for_payment!

      payment_event = Transaction.new.payment(payment_transaction)
      EventSender.serve!(event: payment_event, type: 'transitions.payment', topics: 'transitions')
    end
  end
end
