class LifecycleTaskEvent < BaseEvent
  def assigned(task)
    data = {
      public_id: task.public_id,
      employee_public_id: task.employee.public_id
    }

    build_event('TaskAssigned', data)
  end

  def reassigned(task)
    data = {
      public_id: task.public_id,
      employee_public_id: task.employee.public_id
    }

    build_event('TaskReassigned', data)
  end

  def completed(task)
    data = {
      public_id: task.public_id
    }

    build_event('TaskCompleted', data)
  end
end
