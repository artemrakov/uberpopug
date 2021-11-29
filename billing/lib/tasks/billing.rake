task billing: :environment do
  puts "Run billing cycle"

  # 1 option
  employees = Account.employee

  employees.each do |employee|
    active_cycle = employee.active_cycle

    BillingCycleService.setup_new_cycle(employee)
    BillingCycleService.close(active_cycle)
    PaymentService.pay(account, active_cycle)
  end

  # 2 option
  employees = Account.employee

  employees.each do |employee|
    active_cycle = employee.active_cycle

    BillingCycleService.setup_new_cycle(employee)
    BillingCycleService.close(active_cycle)
    PaymentService.setup_payment(employee)

    # cannot call PaymentService.pay_with here as some of the accounts might
    # not have payment
  end

  payments = Payment.where(state: :created)
  payments.each do |payment|
    PaymentService.pay_with(payment)
  end
end
