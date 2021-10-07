# frozen_string_literal: true

class AppSerializer < ActiveModel::Serializer
  attributes :token, :name, :chat_count, :created_at, :updated_at

  # has_many :chats, serializer: ChatSerializer
end
