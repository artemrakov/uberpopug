class BillingCycle < ApplicationRecord
  belongs_to :account

  aasm :state do
    state :created, initial: true
    state :in_process
    state :completed

    event :start do
      transitions to: :in_process
    end

    event :complete do
      transitions to: :completed
    end
  end
end
