class Chat < ApplicationRecord
  belongs_to :application

  has_many :message, dependent: :destroy
  validates :number, uniqueness: {scope: :application_id}
end
