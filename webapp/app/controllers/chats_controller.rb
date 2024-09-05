class ChatsController < ApplicationController
  before_action :find_application, only: [:index, :show, :destroy, :create]
  before_action :find_chat, only: [:show, :destroy]

  def index
    puts "finding chats for #{ @application.id.to_s }"
    puts @application.token.to_s
    chats = Chat.where(application_id: @application.id)
    render json: chats.as_json(except: [:id, :application_id])
  end

  def show
    render json: @chat.as_json(except: [:id, :application_id])
  end

  def create
    latest_chat_number = @application.chat.maximum(:number) || 0
    queued_chats = $redis.incr("queued_chats_count_#{@application.token}")

    new_chat_number = latest_chat_number + queued_chats

    payload = {
      application_id: @application.id,
      number: new_chat_number
    }

    $redis.rpush("queued_chats", payload)

    render json: {
      number: new_chat_number,
      messages_count: 0
    }
  end

  def update
    render body: nil, status: :method_not_allowed
  end

  def destroy
    @chat.destroy
    render body: nil, status: :no_content
  end

  private
  def find_application
    @application = Application.find_by(token: params[:application_token])

    unless @application
      render json: { error: "Application not found" }, status: :not_found
    end
  end

  def find_chat
    @chat = Chat.find_by(
      application_id: @application.id,
      number: params[:number]
    )

    unless @chat
      render json: { error: "Chat not found" }, status: :not_found
    end
  end
end
