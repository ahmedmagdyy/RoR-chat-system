# frozen_string_literal: true

require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: '/sidekiq'
  get '/apps/:app_token/chats/:chat_number/messages/search/', to: 'messages#search', as: 'messages_search'
  resources :apps, param: :token, only: %i[index create show update] do
    resources :chats, param: :number, only: %i[index create show] do
      resources :messages, param: :message_number, only: %i[index create show update]
    end
  end
end
