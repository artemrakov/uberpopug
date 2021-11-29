class BaseEvent
  def initialize(version = 1)
    @id = SecureRandom.uuid
    @version = version
    @time = Time.zone.now.to_s
    @producer = 'billing_service'
  end

  def billing_event_data
    {
      event_id: @id,
      event_version: @version,
      event_time: @time,
      producer: @producer
    }
  end

  def build_event(event_name, data)
    {
      **billing_event_data,
      event_name: event_name,
      data: data
    }
  end
end
