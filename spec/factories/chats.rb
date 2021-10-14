# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    chat_number { Faker::Number.between(from: 1, to: 10) }
    chat_number_app_token { Faker::Alphanumeric.alpha(number: 10) }
  end
end
