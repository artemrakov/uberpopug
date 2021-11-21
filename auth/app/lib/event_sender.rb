class EventSender
  class << self
    def serve!(event:, type:, topic:, version: 1)
      result = SchemaRegistry.validate_event(event, type, version: version)

      if result.success?
        WaterDrop::SyncProducer.call(event.to_json, topic: topic)
      else
        raise result
      end
    end
  end
end
