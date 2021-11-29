class BillingCycleEvent < BaseEvent
  def cannot_close(billing_cycle)
    data = {
      public_id: billing_cycle.public_id,
      amount: amount,
      account_public_id: account.public_id
    }

    build_event('BillingEventCannotClose', data)
  end

  def closed(billing_cycle)
    data = {
      public_id: billing_cycle.public_id
    }

    build_event('BillingEventClosed', data)
  end
end
