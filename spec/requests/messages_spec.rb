# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages Api', type: :request do
  # initialize test data
  # let!(:test_message_app_test) { create(:app) }
  # let(:test_message_app_token) { test_message_app_test.token }
  #
  # let!(:test_message_chat_test) { create(:chat, app_token: test_message_app_token) }
  #
  # let(:test_message_chat_number) { test_message_chat_test.first.chat_number }
  # let(:chat_ref_key) { test_message_chat_test.first.chat_number_app_token }
  #
  # let!(:messages_test) { create_list(:message, 10, chat_ref: chat_ref_key) }
  #
  # Test suite for GET /apps/:app_token/chats/:chat_number/messages
  # describe 'GET /apps/:app_token/chats/:chat_number/messages' do
  #   before { get "/apps/#{test_message_app_token}/chats/#{test_message_chat_number}/messages" }
  #
  #   it 'returns app' do
  #     expect(json).not_to be_empty
  #     expect(json.size).to eq(10)
  #   end
  #
  #   it 'returns status code 200' do
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
