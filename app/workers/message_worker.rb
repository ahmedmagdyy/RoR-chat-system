# frozen_string_literal: true

class MessageWorker
  include Sidekiq::Worker

  def perform(chat_ref, body, message_number)
    chat = Chat.find_by(chat_number_app_token: chat_ref)
    if chat
      message = Message.create!(message_number: message_number, body: body,
                                chat_ref: chat_ref)
      chat.message_count = chat.message_count + 1 if message.save!
      chat.save!
    else
      raise StandardError, 'Chat not found! Failed Create Message!'
    end
  rescue Exception => e
    puts 'Failed save Message'
    puts e.message
    RedisCache.redis.decr(chat_ref)
  else
    puts 'Done save message'
  end
end
