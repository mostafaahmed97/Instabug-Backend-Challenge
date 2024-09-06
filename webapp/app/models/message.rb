class Message < ApplicationRecord
  belongs_to :chat
  validates :number, uniqueness: {scope: :application_id}
end
