class Chat < ApplicationRecord
  belongs_to :app, foreign_key: :app_token

  # validation
  validates_presence_of :app_token, :chat_number, :chat_number_app_token
end
