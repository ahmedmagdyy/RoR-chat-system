# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    message_number { Faker::Number.between(from: 1, to: 20) }
    body { Faker::Lorem.sentence }
  end
end
