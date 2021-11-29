task billing: :environment do
  puts "Run billing cycle"

  billling_cycles = BillingCycle.where(status: :in_process)

  billling_cycles.each do |cycle|
    account = cycle.account
    BillingCycleService.setup_new_cycle(account)
    BillingCycleService.close(cycle)
  end

  payments = Payment.where(status: :waiting_for_payment)
  payments.each do |payment|
    PaymentService.pay(payment)
  end
end
