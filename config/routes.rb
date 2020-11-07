Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:show,:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :follow, :unfollow, :follow_list, :follower_list,] do 
    member do
      get "follow_list"
      get "follower_list"
    end
  end

  resources :relationships, only: [:create, :destroy]
  
  root to: "home#top"
  get "/about", to: "home#about"
  
end
