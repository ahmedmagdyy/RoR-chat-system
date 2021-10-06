class App < ApplicationRecord
  has_many :chats, dependent: :destroy, foreign_key: :app_token, primary_key: :token

  # validations
  validates_presence_of :name, :token, :chat_count
end
