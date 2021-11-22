class Payment < ApplicationRecord
  belongs_to :transactions
  belongs_to :billing_cycles
end
