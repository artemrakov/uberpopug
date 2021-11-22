task billing: :environment do
  puts "Run billing cycle"

  BillingCycleService.daily_cycle

  puts "Done."
end
