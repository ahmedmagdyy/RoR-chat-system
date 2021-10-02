# frozen_string_literal: true

FactoryBot.define do
  factory :app do
    name { Faker::Lorem.word }
    token { Faker::Internet.uuid }
  end
end
