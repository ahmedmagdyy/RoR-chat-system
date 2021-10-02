# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'APP API', type: :request do
  # initialize test data
  let!(:app) { create_list(:app, 10) }
  let(:app_token) { app.first.token }

  # Test suite for GET /app
  describe 'GET /app' do
    # make HTTP get request before each example
    before { get '/app' }

    it 'returns app' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /app/:id
  describe 'GET /app/:id' do
    before { get "/app/#{app_token}" }

    context 'when the record exists' do
      it 'returns the app' do
        expect(json).not_to be_empty
        expect(json['token']).to eq(app_token)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:app_token) { '10599bd1-5b74-4ab5-a161-ca4279e3c913' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find app/)
      end
    end
  end

  # Test suite for POST /app
  describe 'POST /app' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', app_token: '10599bd1-5b74-4ab5-a161-ca4279e3c913' } }

    context 'when the request is valid' do
      before { post '/app', params: valid_attributes }

      it 'creates a app' do
        expect(json['name']).to eq('Learn Elm')
        expect(json['token']).to eq('10599bd1-5b74-4ab5-a161-ca4279e3c913')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/app', params: { name: nil } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  # Test suite for PUT /app/:token
  describe 'PUT /app/:token' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/app/#{app_token}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end
