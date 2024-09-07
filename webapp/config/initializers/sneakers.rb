# Sneakers is a library for background tasks that works with RabbitMQ
require 'sneakers'

user = ENV['RABBITMQ_USER']
pwd = ENV['RABBITMQ_PASSWORD']
host = ENV['RABBITMQ_HOST']
port = ENV['RABBITMQ_PORT']

amqp_url = "amqp://#{user}:#{pwd}@#{host}:#{port}"

Sneakers.configure(
  amqp: amqp_url,
  ack: true
)