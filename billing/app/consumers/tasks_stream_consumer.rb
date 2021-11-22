class TasksStreamConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      data = payload['data']

      case payload['event_name']
      when 'TaskCreated'
        Task.create!(
          public_id: data['public_id'],
          description: data['description']
        )
      else
        # store in db
      end
    end
  end
end
