# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/index'

  namespace :admin do
    resources :members
    root to: 'members#index'
  end

  devise_for :members
  resources :members
  root to: 'home#index'

  resources :posts do
    resources :comments, shallow: true
    root to: 'posts#index'
  end
end
