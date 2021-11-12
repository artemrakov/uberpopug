class Account < ApplicationRecord
  has_many :auth_identities, dependent: :destroy
  has_many :tasks, foreign_key: :employee_id, dependent: :destroy

  enum role: {
    admin: 'admin',
    employee: 'employee',
    repairman: 'repairman',
    accounting_clerk: 'accounting_clerk'
  }, _default: 'admin'

  def guest?
    false
  end

  def to_s
    [full_name, email].join(' ')
  end
end
