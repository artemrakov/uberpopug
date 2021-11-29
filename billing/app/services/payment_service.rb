class PaymentService
  class << self
    def pay(transaction)
      payment = Payment.create!(
        amount: amount,
        transaction: transaction,
        billing_cycle: billing_cycle,
        account: account
      )
      # payment_created = PaymentEvent.new.created
      # EventSender.serve! (event)

      # call payment provider

      payment.complete!

      # payment_completed = PaymentEvent.new.completed
      # EventSender.serve! (event)
    end
  end
end
