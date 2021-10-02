# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :app, param: :token, only: %i[index create show update] do
    resources :chat, param: :number, only: %i[index create show update]
  end
end
