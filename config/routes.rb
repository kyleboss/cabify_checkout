# frozen_string_literal: true

Rails.application.routes.draw do
  resources :scans, only: %i[update destroy create]
  resources :checkouts, only: %i[new create update]
  resources :products, only: %i[index update create destroy]
  root to: 'checkouts#new'

  get '/admin', to: 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
