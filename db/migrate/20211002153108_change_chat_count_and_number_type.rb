class ChangeChatCountAndNumberType < ActiveRecord::Migration[6.1]
  def self.up
    change_table :chats do |t|
      t.change :message_count, :integer
      t.change :chat_number, :integer
    end
  end

  def self.down
    change_table :chats do |t|
      t.change :message_count, :numeric
      t.change :chat_number, :numeric
    end
  end
end
