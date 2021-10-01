class App < ApplicationRecord
  has_many :chats, dependent: :destroy, foreign_key: :app_token

  # validations
  validates_presence_of :name, :token
end
