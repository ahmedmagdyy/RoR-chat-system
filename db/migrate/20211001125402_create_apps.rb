# frozen_string_literal: true

class CreateApps < ActiveRecord::Migration[6.1]
  def change
    create_table :apps do |t|
      t.string :token, index: { unique: true }, null: false
      t.string :name, null: false
      t.numeric :chat_count, default: 0
      t.timestamps
    end
  end
end
