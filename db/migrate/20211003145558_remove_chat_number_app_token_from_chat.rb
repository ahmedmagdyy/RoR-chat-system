class RemoveChatNumberAppTokenFromChat < ActiveRecord::Migration[6.1]
  def self.up
    change_table :chats do |t|
      t.remove :chat_number_app_token
    end
  end

  def self.down
    add_column :chats, :chat_number_app_token, :integer
  end


end
