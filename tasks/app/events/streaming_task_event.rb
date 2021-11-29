class StreamingTaskEvent < BaseEvent
  def created(task)
    data = {
      description: task.description,
      public_id: task.public_id,
      status: task.status,
      employee_public_id: task.employee.public_id
    }

    build_event('TaskCreated', data)
  end
end
