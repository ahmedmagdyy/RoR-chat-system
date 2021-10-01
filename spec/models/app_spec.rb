require 'rails_helper'

RSpec.describe App, type: :model do
  # Association test
  # ensure App model has a 1:m relationship with the Chat model
  it { should have_many(:chats).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:token) }
end
