class Payment < ApplicationRecord
  belongs_to :transaction, class_name: 'Transaction::Payment'
  belongs_to :billing_cycle
end
