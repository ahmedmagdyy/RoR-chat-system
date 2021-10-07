class Chat < ApplicationRecord
  belongs_to :app, foreign_key: :app_token, optional: true
  has_many :messages, dependent: :destroy, foreign_key: :chat_ref, primary_key: :chat_number_app_token

  # validation
  validates_presence_of :app_token, :chat_number, :message_count
end
