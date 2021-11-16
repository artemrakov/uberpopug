class Task < ApplicationRecord
  include AASM

  belongs_to :employee, class_name: 'Account'

  after_save do
    reload
  end

  aasm :status do
    state :in_progress, initial: true
    state :completed

    event :complete do
      transitions to: :completed
    end
  end
end
