class Payment < ApplicationRecord
  belongs_to :billing_transaction, class_name: 'Transaction::Payment'
  belongs_to :billing_cycle
end
