require "rufus-scheduler"

scheduler = Rufus::Scheduler.singleton

scheduler.every "10m" do

  Rails.logger.info "Updating chats_count & messages_count"

  Application.all.each do |application|
    application.chats_count = Chat.where(application_id: application.id).count
    application.save
  end

  Chat.all.each do |chat|
    chat.messages_count = Message.where(chat_id: chat.id).count
    chat.save
  end
end
