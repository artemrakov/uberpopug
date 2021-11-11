# frozen_string_literal: true

WaterDrop.setup do |config|
  config.deliver = true
  config.kafka.seed_brokers = ['kafka://206.81.22.88:9092']
  config.logger = Rails.logger
end
