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

    def serve_batch!(events:, type:, topic:, version: 1)
      results = events.map do |event|
        SchemaRegistry.validate_event(event, type, version: version)
      end

      if results.all?(&:success?)
        WaterDrop::BatchSyncProducer.call(events.map(&:to_json), topic: topic)
      else
        failed_results = results.select(&:failure?)
        raise failed_results
      end
    end
  end
end
