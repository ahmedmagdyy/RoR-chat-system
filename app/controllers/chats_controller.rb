# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_current_app

  def index
    if @app
      render json: @app.chats
    else
      render json: { message: 'App/Chat Not Found' }, status: :not_found
    end
  end

  def show
    if (@chat = @app.chats.find_by(chat_number: params[:number]))
      render json: @chat
    else
      render json: { message: 'Chat Not Found' }, status: :not_found
    end
  end

  def create
    render json: { message: 'App not found!' }, status: :not_found if @app.nil?
    chat_number = RedisCache.redis.incr(params[:app_token])
    ChatWorker.perform_async(chat_number, params[:app_token])
    render json: { chat_number: chat_number }
  end

  private

  def set_current_app
    @app = App.find_by_token(params[:app_token])
  end
end
