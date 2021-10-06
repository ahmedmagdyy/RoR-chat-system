# frozen_string_literal: true

class ChangeChatNumberToNotNull < ActiveRecord::Migration[6.1]
  def self.up
    change_table :chats do |t|
      t.change :chat_number, :integer, null: false
    end
  end

  def self.down
    change_table :chats do |t|
      t.change :chat_number, :integer, null: true
    end
  end
end
