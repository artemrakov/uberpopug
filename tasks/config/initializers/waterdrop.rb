# frozen_string_literal: true

WaterDrop.setup do |config|
  config.deliver = true
  config.kafka.seed_brokers = ['kafka://206.81.22.88:9092']
  config.logger = Rails.logger
end

module WaterDrop
  class BatchSyncProducer < BaseProducer
    def self.call(messages, options)
      attempts_count ||= 0
      attempts_count += 0

      validate!(options)
      return unless WaterDrop.config.deliver

      messages.each { |message| DeliveryBoy.produce(message, **options) }
      DeliveryBoy.deliver_messages
    rescue Kafka::Error => e
      graceful_attempt?(attempts_count, messages, options, e) ? retry : raise(e)
    end
  end
end
