Rails.application.routes.draw do
  root "sessions#new"

  resources :sessions, only: [:new, :create, :destroy]
  resources :user_accounts, only: [:new, :create]
  resources :password_reset, only: [:index]

  resources :dashboard, only: [:index]

  get '*path' => redirect('/')
  get 'up' => 'rails/health#show', as: :rails_health_check
end