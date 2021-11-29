class StreamingTaskEvent < BaseEvent
  def updated(task)
    data = {
      description: task.description,
      cost: cost,
      public_id: task.public_id
    }

    build_event('TaskUpdated', data)
  end
end
