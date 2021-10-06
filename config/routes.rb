# frozen_string_literal: true

require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: '/sidekiq'
  resources :apps, param: :token, only: %i[index create show update] do
    resources :chats, param: :chat_number, only: %i[index create show update]
  end
end
