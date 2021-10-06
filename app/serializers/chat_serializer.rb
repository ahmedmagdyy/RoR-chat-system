class ChatSerializer < ActiveModel::Serializer
  attributes :chat_number, :app_token, :message_count, :created_at, :updated_at

  belongs_to :app, serializer: AppSerializer
  # has_many :messages
end
