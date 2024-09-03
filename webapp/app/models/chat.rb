class Chat < ApplicationRecord

  belongs_to :application
  validates :number, uniqueness: {scope: :application_id}
end
