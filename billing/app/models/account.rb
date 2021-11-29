class Account < ApplicationRecord
  has_many :auth_identities, dependent: :destroy

  def guest?
    false
  end

  def to_s
    [full_name, email].join(' ')
  end

  def initialize(attrs = nil)
    defaults = {
      balance: 0
    }

    attrs_with_defaults = attrs ? defaults.merge(attrs) : defaults
    super(attrs_with_defaults)
  end
end
