class Transaction < ApplicationRecord
  validates :accounting_entry, presence: true

  after_save do
    reload
  end

  enum accounting_entry: {
    credit: 'credit',
    debit: 'debit'
  }
end
