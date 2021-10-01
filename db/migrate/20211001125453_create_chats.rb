# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :app_token
      t.numeric :message_count, default: 0
      t.numeric :chat_number
      t.string :chat_number_app_token, index: { unique: true }, null: false

      t.timestamps
    end
    add_foreign_key :chats, :apps, column: :app_token, primary_key: :token
  end
end
