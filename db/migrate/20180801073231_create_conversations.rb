class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.text :messages
      t.integer :chat_room_id
      t.integer :sender_id
      t.string :message_type
      t.integer :message_type_id

      t.timestamps
    end
    add_index :conversations, :chat_room_id
  end
end
