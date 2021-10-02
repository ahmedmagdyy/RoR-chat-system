class AppSerializer < ActiveModel::Serializer
  attributes :token, :name, :chat_count, :created_at, :updated_at

  has_many :chats
end
