class TaskEvent
  class << self
    def created(task)
      {
        event_name: 'TaskCreated',
        data: {
          description: task.description,
          public_id: task.public_id,
          status: task.status,
          employee_public_id: task.employee.public_id
        }
      }
    end

    def assigned(task)
      {
        event_name: 'TaskAssigned',
        data: {
          public_id: task.public_id,
          employee_public_id: task.employee.public_id
        }
      }
    end

    def reassigned(task)
      {
        event_name: 'TaskReassigned',
        data: {
          public_id: task.public_id,
          employee_public_id: task.employee.public_id
        }
      }
    end

    def completed(task)
      {
        event_name: 'TaskCompleted',
        data: {
          public_id: task.public_id,
          status: task.status
        }
      }
    end
  end
end
