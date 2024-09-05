# Sneakers is a library for background tasks that works with RabbitMQ
require 'sneakers'

# TODO: replace with env
amqp_url = 'amqp://guest:guest@localhost:5672'

Sneakers.configure(
  amqp: amqp_url,
  ack: true
)