class Payment < ApplicationRecord
  include AASM

  belongs_to :billing_transaction, class_name: 'Transaction::Payment'
  belongs_to :billing_cycle
  belongs_to :account

  aasm :status do
    state :created, initial: true
    state :waiting_for_payment
    state :failed
    state :completed

    event :complete do
      transitions to: :completed
    end
  end
end
