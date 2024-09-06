class Message < ApplicationRecord
  belongs_to :chat
  validates :number, uniqueness: {scope: :chat_id}
end
