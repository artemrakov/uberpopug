class TasksStreamConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      data = payload['data']

      case payload['event_name']
      when 'TaskCreated'
        cost = (10..20).to_a.sample * 100

        Task.create!(
          public_id: data['public_id'],
          description: data['description'],
          cost: cost
        )

        event = StreamingTaskEvent.new.updated(task)
        EventSender.serve!(event: event, type: 'tasks.updated', version: 1, topic: 'task-stream')
     else
        # store in db
      end
    end
  end
end
