class Transaction < ApplicationRecord
  validates :entry, presence: true

  after_save do
    reload
  end

  enum entry: {
    credit: 'credit',
    debit: 'debit'
  }
end
