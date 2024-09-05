require "json"

class ChatWorker
  include Sneakers::Worker

  from_queue $CHATS_QUEUE

  def work(msg)
    parsed_chat = JSON.parse(msg)
    Chat.new(parsed_chat).save
  end
end