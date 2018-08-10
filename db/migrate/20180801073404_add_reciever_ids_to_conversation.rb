class AddRecieverIdsToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :reciever_ids, :text, array:true, default: []
  end
end
