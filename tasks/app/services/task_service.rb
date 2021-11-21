class TaskService
  def self.reassign(tasks, employees)
    tasks.each do |task|
      task.employee = employees.sample
      task.save!
    end

    events = tasks.map do |task|
      {
        event_id: SecureRandom.uuid,
        event_version: 1,
        event_time: Time.zone.now.to_s,
        producer: 'task_service',
        event_name: 'TaskReassigned',
        data: {
          public_id: task.public_id,
          employee_public_id: task.employee.public_id
        }
      }
    end

    EventSender.serve_batch!(events: events, type: 'tasks.reassigned', topic: 'tasks-lifecycle')
  end
end
