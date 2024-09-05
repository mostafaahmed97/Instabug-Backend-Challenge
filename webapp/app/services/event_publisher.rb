class EventPublisher
  def self.publish(message, queue_name)
    @@channel ||= $bunny.create_channel

    # Publish to a queue, will be bound to the default exchange,
    # default exchange's type is direct
    @@queue = @@channel.queue(queue_name, durable: true)
    @@queue.publish(message, :routing_key => @@queue.name)
  end
end