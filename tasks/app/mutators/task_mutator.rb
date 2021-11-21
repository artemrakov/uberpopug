class TaskMutator
  class << self
    def create(params)
      task = Task.new(params)
      employee = Account.employee.sample
      task.employee = employee

      if task.save
        created_event = StreamingTaskEvent.new.created(task)
        EventSender.serve!(event: created_event, type: 'tasks.created', version: 1, topic: 'tasks-stream')

        assigned_event = LifecycleTaskEvent.new.assigned(task)
        EventSender.serve!(event: assigned_event, type: 'tasks.assigned', version: 1, topic: 'tasks-lifecycle')
      end

      task
    end
  end
end
