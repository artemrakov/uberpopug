# frozen_string_literal: true

class Account < ApplicationRecord
  include AASM

  has_secure_password

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all
  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  enum role: { admin: 'admin', employee: 'employee' }, _default: 'admin'

  aasm :state do
    state :active, initial: true
    state :removed

    event :activate do
      transitions to: :active
    end

    event :mark_as_removed do
      transitions to: :removed
    end
  end

  def guest?
    false
  end
end
