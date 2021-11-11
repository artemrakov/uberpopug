class Task < ApplicationRecord
  belongs_to :employee, class_name: 'Account'
end
