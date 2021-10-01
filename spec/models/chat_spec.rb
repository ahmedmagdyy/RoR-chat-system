# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
  # Association test

  # ensure Chat model has a m:1 relationship with the App model
  it { should belong_to(:app) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:app_token) }
  it { should validate_presence_of(:chat_number) }
  it { should validate_presence_of(:chat_number_app_token) }
end
