# frozen_string_literal: true

Rails.application.routes.draw do
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index' # вместо root_url/root_path сгенерирует store_index_url/path
  resources :products
end
