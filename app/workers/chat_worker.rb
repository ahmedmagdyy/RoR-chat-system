# frozen_string_literal: true

class ChatWorker
  include Sidekiq::Worker

  def perform(chat_number, app_token)
    app = App.find_by_token(app_token)
    if app
      chat = Chat.create!(chat_number: chat_number, app_token: app_token,
                          chat_number_app_token: "#{chat_number}_#{app_token}")
      app.chat_count = app.chat_count + 1 if chat.save!
      app.save!
    else
      raise StandardError, 'App not found! Failed Creating Chat!'
    end
  rescue Exception => e
    puts 'Failed save chat'
    puts e.message
    RedisCache.redis.decr(app_token)
  else
    puts 'Done save chat'
  end
end
