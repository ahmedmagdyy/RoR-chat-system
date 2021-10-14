# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chat API', type: :request do
  # Initialize the test data
  let!(:app_test_chat) { create(:app) }
  let!(:chats_test) { create_list(:chat, 5, app_token: app_test_chat.token) }
  let(:app_token_test) { app_test_chat.token }
  let(:chat_number_test) { chats_test.first.chat_number }

  # Test suite for GET /apps/:app_token/chats/
  describe 'GET /apps/:app_token/chats/' do
    before { get "/apps/#{app_token_test}/chats" }

    it 'returns chats' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /apps/:app_token/chats/:chat_number
  describe 'GET /apps/:app_token/chats/:chat_number' do
    before { get "/apps/#{app_token_test}/chats/#{chat_number_test}" }

    context 'when the record exists' do
      it 'returns the chat' do
        expect(json).not_to be_empty
        expect(json['chat_number']).to eq(chat_number_test)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:chat_number_test) { 25 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Chat Not Found/)
      end
    end
  end

  # Test suite for POST /apps/:app_token/chats
  describe 'POST /apps/:app_token/chats' do
    context 'when the request is valid' do
      before { post "/apps/#{app_token_test}/chats/" }

      it 'creates a chat' do
        expect(json['chat_number']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/apps/9b6476d9-a201-4f50-9662-e8a5fd83536f/chats/' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
