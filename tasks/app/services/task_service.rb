class TaskService
  def self.reassign(tasks, employees)
    tasks.each do |task|
      task.employee = employees.sample
      task.save!
    end

    events = tasks.map do |task|
      {
        event_name: 'TaskReassigned',
        data: {
          public_id: task.public_id,
          employee_public_id: task.employee.public_id
        }
      }.to_json
    end

    WaterDrop::BatchSyncProducer.call(events, topic: 'tasks-lifecycle')
  end
end
