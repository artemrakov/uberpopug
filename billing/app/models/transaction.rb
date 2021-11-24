class Transaction < ApplicationRecord
  belongs_to :billing_cycle
  belongs_to :account

  validates :accounting_entry, presence: true

  after_save do
    reload
  end

  enum accounting_entry: {
    credit: 'credit',
    debit: 'debit'
  }
end
