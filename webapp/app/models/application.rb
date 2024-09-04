class Application < ApplicationRecord
  validates :name, presence: true
  has_secure_token :token

  has_many :chat, dependent: :destroy
end
