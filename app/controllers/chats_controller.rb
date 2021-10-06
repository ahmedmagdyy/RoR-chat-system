# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_current_app
  # before_action :set_chat, only: %i[index]
  # before_action :set_chats, only: %i[show]

  def index
    if @chats = @app.chats
      render json: @chats
    else
      render json: { message: 'App/Chat Not Found' }, status: :not_found
    end
  end

  def show
    if @chat = @app.chats.find_by(chat_number: params[:chat_number])
      render json: @chat
    else
      render json: { message: 'App or Chat Not Found' }, status: :not_found
    end
  end

  def create
    render json: { message: 'App not found!'}, status: :not_found if @app.nil?
    chat_number = RedisCache.redis.incr(params[:app_token])
    ChatWorker.perform_async(chat_number, params[:app_token])
    render json: { chat_number: chat_number }
  end

  private

  def set_current_app
    @app = App.find_by_token(params[:app_token])
  end

  # def set_chat
  #   @chat = @app.chats.find_by!(params[:chat_number]) if @app
  # end

  # def set_chats
  #   puts @app.inspect
  #   @chats = @app.chats if @app
  # end


end
