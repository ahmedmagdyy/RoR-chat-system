class Message < ApplicationRecord
  include Searchable
  belongs_to :chat, foreign_key: :chat_ref, optional: true

  validates_presence_of :chat_ref, :body, :message_number
end
