# Bunny is a RabbitMQ client

$CHATS_QUEUE = 'chats'
$MESSAGES_QUEUE = 'messages'

# TODO: Update with env var
$bunny = Bunny.new(
  :host => '127.0.0.1',
  :port => 5672,
  automatically_recover: true
)

$bunny.start

