class Account < ApplicationRecord
  has_many :auth_identities, dependent: :destroy

  def guest?
    false
  end
end
