require "elasticsearch/model"

class Message < ApplicationRecord
  # To automatically update Elasticsearch's index on CRUD ops
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat

  validates :text, presence: true
  validates :number, uniqueness: {scope: :chat_id}

  # Creates an Elasticsearch index on `text` column
  settings index: { number_of_shards: 1 } do
    mapping do
      indexes :text, type: 'text'
    end
  end

  def self.search(query, chat_id)
    results = __elasticsearch__.search(
      query: {
        # Combines multiple queries
        bool: {
          # All below conditions must match
          must: [
            # Fuzzily search text column
            { fuzzy: { text: query } },
            # Exact match on chat_id
            { match: { chat_id: chat_id } }
          ]
        }
      }
    ).records

    results
  end
end
