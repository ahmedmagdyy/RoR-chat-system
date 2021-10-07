# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_current_chat
  # before_action :set_chat, only: %i[index]
  # before_action :set_chats, only: %i[show]

  def index
    if @chat
      render json: @chat.messages
    else
      render json: { message: 'Chat Not Found' }, status: :not_found
    end
  end

  def show
    if (@message = @chat.message.find_by(message_number: params[:message_number]))
      render json: @message
    else
      render json: { message: 'Message Not Found' }, status: :not_found
    end
  end

  def create
    render json: { message: 'Chat not found!' }, status: :not_found if @chat.nil?
    chat_number_app_token = "#{params[:chat_number]}_#{params[:app_token]}"
    msg_number = RedisCache.redis.incr(chat_number_app_token)
    MessageWorker.perform_async(chat_number_app_token, params[:body], msg_number)
    render json: { message_number: msg_number }
  end

  private

  def message_param
    params.permit(:body)
  end

  def set_current_chat
    @chat = Chat.find_by(chat_number_app_token: "#{params[:chat_number]}_#{params[:app_token]}")
  end
end
