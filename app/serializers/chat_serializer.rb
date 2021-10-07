# frozen_string_literal: true

class ChatSerializer < ActiveModel::Serializer
  attributes :chat_number, :app_token, :message_count, :created_at, :updated_at, :chat_number_app_token

  # belongs_to :app, serializer: AppSerializer
  # has_many :messages, serializer:MessageSerializer
end
