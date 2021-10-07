# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :message_number, :chat_ref, :body, :created_at, :updated_at
end
