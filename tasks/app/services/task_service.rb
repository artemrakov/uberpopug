class TaskService
  def self.reassign(tasks, employees)
    tasks.each do |task|
      task.employee = employees.sample
      task.save!

      event = TaskEvent.reassigned(task)
      WaterDrop::SyncProducer.call(event.to_json, topic: 'tasks')
    end
  end
end
