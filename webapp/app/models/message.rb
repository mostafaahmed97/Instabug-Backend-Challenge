class Message < ApplicationRecord
  belongs_to :chat

  validates :text, presence: true
  validates :number, uniqueness: {scope: :chat_id}
end
