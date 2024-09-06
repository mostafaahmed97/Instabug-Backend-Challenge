class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.text :text
      t.references :chat, foreign_key: true
      t.timestamps
    end

    add_index :messages, [:chat_id, :number], unique: true
  end
end
