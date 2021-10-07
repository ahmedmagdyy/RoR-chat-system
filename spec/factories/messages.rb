FactoryBot.define do
  factory :message do
    message_number { "" }
    body { "MyString" }
    chat_id { "" }
    chat { nil }
  end
end
