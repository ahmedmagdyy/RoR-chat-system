class ChangeAppChatCountToInt < ActiveRecord::Migration[6.1]
  def self.up
    change_table :apps do |t|
      t.change :chat_count, :integer
    end
  end

  def self.down
    change_table :apps do |t|
      t.change :chat_count, :integer
    end
  end
end
