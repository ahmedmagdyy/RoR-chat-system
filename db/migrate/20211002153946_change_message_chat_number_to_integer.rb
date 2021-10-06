class ChangeMessageChatNumberToInteger < ActiveRecord::Migration[6.1]
  def self.up
    change_table :messages do |t|
      t.change :chat_id, :integer
    end
  end

  def self.down
    change_table :messages do |t|
      t.change :chat_id, :integer
    end
  end
end
