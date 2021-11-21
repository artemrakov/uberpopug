class TaskMutator
  class << self
    def create(params)
      task = Task.new(params)
      employee = Account.employee.sample
      task.employee = employee

      if task.save
        created_event = {
          **task_event_data,
          event_name: 'TaskCreated',
          data: {
            description: @task.description,
            public_id: @task.public_id,
            status: @task.status,
            employee_public_id: @task.employee.public_id
          }
        }
        EventSender.serve!(event: created_event, type: 'tasks.created', version: 1, topic: 'tasks-stream')

        assigned_event = {
          **task_event_data,
          event_name: 'TaskAssigned',
          data: {
            public_id: @task.public_id,
            employee_public_id: @task.employee.public_id
          }
        }
        EventSender.serve!(event: assigned_event, type: 'tasks.assigned', version: 1, topic: 'tasks-lifecycle')
      end

      task
    end

    def task_event_data
      {
        event_id: SecureRandom.uuid,
        event_version: 1,
        event_time: Time.zone.now.to_s,
        producer: 'task_service'
      }
    end
  end
end
