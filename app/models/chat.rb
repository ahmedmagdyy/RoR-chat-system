class Chat < ApplicationRecord
  belongs_to :app, foreign_key: :app_token, primary_key: :token, optional: true
  # has_many :messages, dependent: :destroy, foreign_key: :chat_id

  # validation
  validates_presence_of :app_token, :chat_number, :message_count
end
