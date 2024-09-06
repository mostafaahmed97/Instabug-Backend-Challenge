require "json"

class MessageWorker
  include Sneakers::Worker

  from_queue $MESSAGES_QUEUE

  def work(msg)
    parsed_msg = JSON.parse(msg)
    Message.new(parsed_msg).save
  end
end
