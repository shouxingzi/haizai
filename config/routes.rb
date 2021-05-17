Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets, only: [:new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'get_cities' 
    end
    resources :rooms, only: [:new, :create, :destroy] do
      resources :messages, only: [:index, :create]
    end
  end
  resources :users, only: :show
end
