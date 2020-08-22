Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:show,:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :follow, :unfollow, :follow_list, :follower_list,] do 
    member do
      post "follow"
      post "unfollow"
      get "follow_list"
      get "follower_list"
    end
  end

  root to: "home#top"
  get "/about", to: "home#about"
  
end
