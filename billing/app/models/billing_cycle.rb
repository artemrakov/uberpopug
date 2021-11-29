class BillingCycle < ApplicationRecord
  include AASM

  has_many :billing_transactions, class_name: 'Transaction'
  belongs_to :account

  after_save do
    reload
  end

  def initialize(attrs = nil)
    defaults = {
      started_at: Time.zone.now
    }

    attrs_with_defaults = attrs ? defaults.merge(attrs) : defaults
    super(attrs_with_defaults)
  end

  aasm :status do
    state :in_process, initial: true
    state :closed

    event :close do
      transitions to: :closed

      after do
        update(ended_at: Time.zone.now)
      end
    end
  end
end
