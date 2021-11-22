class Account < ApplicationRecord
  has_many :auth_identities, dependent: :destroy

  def guest?
    false
  end

  def to_s
    [full_name, email].join(' ')
  end
end
