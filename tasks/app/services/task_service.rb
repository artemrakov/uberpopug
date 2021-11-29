class TaskService
  def self.reassign(tasks, employees)
    tasks.each do |task|
      task.employee = employees.sample
      task.save!
    end

    events = tasks.map { |task| LifecycleTaskEvent.new.reassigned(task) }
    EventSender.serve_batch!(events: events, type: 'tasks.reassigned', topic: 'tasks-lifecycle')
  end
end
