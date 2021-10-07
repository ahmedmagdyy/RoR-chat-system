require 'rails_helper'

RSpec.describe Message, type: :model do
  # Association test

  # ensure Message model has a m:1 relationship with the App model
  it { should belong_to(:chat) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:chat_id) }
  it { should validate_presence_of(:message_number) }
  it { should validate_presence_of(:body) }
end
