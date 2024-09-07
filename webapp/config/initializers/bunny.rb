# Bunny is a RabbitMQ client

$CHATS_QUEUE = 'chats'
$MESSAGES_QUEUE = 'messages'

$bunny = Bunny.new(
  :host => ENV["RABBITMQ_HOST"],
  :port => ENV["RABBITMQ_PORT"],
  automatically_recover: true
)

$bunny.start

