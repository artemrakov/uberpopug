class PaymentService
  class << self
    def setup_payment(account)
      return if account.balance.negative?

      amount = account.balance
      Payment.create!(
        amount: amount,
        # transaction: transaction, ? not transaction i guess ??
        billing_cycle: billing_cycle,
        account: account
      )
      account.update!(balance: 0)
    end

    def pay_with(payment)
      # call payment provider

      payment.complete!
    end

    def pay(account, billing_cycle)
      return if account.balance.negative?

      amount = account.balance
      payment = Payment.create!(
        amount: amount,
        # transaction: transaction, ? not transaction i guess ??
        billing_cycle: billing_cycle,
        account: account
      )
      account.update!(balance: 0)
      # payment_created = PaymentEvent.new.created
      # EventSender.serve! (event)

      # call payment provider

      payment.complete!

      # payment_completed = PaymentEvent.new.completed
      # EventSender.serve! (event)
    end
  end
end
