Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  # post 'tweets', to: 'tweets#cities_select'

  resources :tweets, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :rooms, only: [:new, :create, :destroy] do
      resources :messages, only: [:index, :create]
    end
  end
  resources :users, only: :show
end
