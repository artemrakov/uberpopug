class Payment < ApplicationRecord
  # belongs_to :transaction
  belongs_to :billing_cycle
end
