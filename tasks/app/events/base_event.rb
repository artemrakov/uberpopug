class BaseEvent
  def initialize(version = 1)
    @id = SecureRandom.uuid
    @version = version
    @time = Time.zone.now.to_s
    @producer = 'task_service'
  end

  def task_event_data
    {
      event_id: @id,
      event_version: @version,
      event_time: @time,
      producer: @producer
    }
  end

  def build_event(event_name, data)
    {
      **task_event_data,
      event_name: event_name,
      data: data
    }
  end
end
