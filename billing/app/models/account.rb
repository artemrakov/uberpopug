class Account < ApplicationRecord
  def guest?
    false
  end

  def to_s
    [full_name, email].join(' ')
  end
end
