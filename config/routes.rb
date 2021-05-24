Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  resources :tweets, only: [:new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'get_cities' 
      get 'ajax_tag_search'
      # post 'tag_search'
      get 'search'
    end
    member do
      get 'tag_list'
      get 'prefecture_list'
      get 'city_list'
    end
    resources :rooms, only: [:new, :create, :destroy] do
      resources :messages, only: [:index, :create]
    end
  end
  resources :users, only: :show
end
