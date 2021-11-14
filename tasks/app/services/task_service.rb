class TaskService
  def self.reassign(tasks, employees)
    tasks.each do |task|
      task.employee = employees.sample
      task.save!

      event = {
        event_name: 'TaskReassigned',
        data: {
          public_id: task.public_id,
          employee_public_id: task.employee.public_id
        }
      }.to_json
      WaterDrop::SyncProducer.call(event, topic: 'tasks-lifecycle')
    end
  end
end
