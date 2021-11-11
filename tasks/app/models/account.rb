class Account < ApplicationRecord
  has_many :auth_identities

  def guest?
    false
  end
end
