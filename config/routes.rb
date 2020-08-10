Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:show,:create, :destroy]
  end
  resources :users
  root to: "home#top"
  get "/about", to: "home#about"
  
end
