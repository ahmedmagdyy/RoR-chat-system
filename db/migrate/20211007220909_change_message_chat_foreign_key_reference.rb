# frozen_string_literal: true

class ChangeMessageChatForeignKeyReference < ActiveRecord::Migration[6.1]
  def self.up
    remove_reference(:messages, :chat, foreign_key: true)
    add_column(:messages, :chat_ref, :string)
    add_column(:chats, :chat_number_app_token, :string, null: false)
    add_index(:chats, :chat_number_app_token, unique: true)
    add_foreign_key(:messages, :chats, column: :chat_ref, primary_key: 'chat_number_app_token', on_delete: :cascade)
  end

  def self.down
    remove_foreign_key(:messages, column: :chat_ref)
    remove_index(:chats, :chat_number_app_token)
    remove_column(:chats, :chat_number_app_token)
    remove_column(:messages, :chat_ref)
    add_reference(:messages, :chat, foreign_key: true)
  end
end
