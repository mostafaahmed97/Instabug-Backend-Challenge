require "json"

class MessagesController < ApplicationController
  before_action :find_application_and_chat
  before_action :find_message, only: [:show, :destroy, :update]


  def index
    if params[:text]
      messages = Message.search(params[:text], @chat.id)
    else
      messages = Message.where(chat_id: @chat.id)
    end

    render json: messages.as_json(except: [:id, :chat_id])
  end

  def show
    render json: @message.as_json(except: [:id, :chat_id])
  end

  def create
    text = params[:text] || ""
    new_msg_number = $redis.incr("msgs_count_#{@application.token}_#{@chat.number}")

    payload = {
      chat_id: @chat.id,
      number: new_msg_number,
      text: text
    }

    EventPublisher.publish(JSON.generate(payload), $MESSAGES_QUEUE)

    render json: {
      number: new_msg_number,
      text: text
    }
  end

  def update
    text = params[:text] || ""

    @message.update_attribute("text", text)
    render json: @message.as_json(except: [:id, :chat_id])
  end

  def destroy
    @message.destroy
    render body: nil, status: :no_content
  end

  private
  def find_application_and_chat
    @application = Application.find_by(
      token: params[:application_token]
    )

    unless @application
      return render json: { error: "Application not found" }, status: :not_found
    end

    @chat = Chat.find_by(
      application_id: @application.id,
      number: params[:chat_number]
    )

    unless @chat
      return render json: { error: "Chat not found" }, status: :not_found
    end
  end

  def find_message
    @message = Message.find_by(
      chat_id: @chat.id,
      number: params[:number]
    )

    unless @message
      render json: { error: "Message not found" }, status: :not_found
    end
  end

end