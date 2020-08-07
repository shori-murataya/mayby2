Rails.application.routes.draw do
  devise_for :users
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:show, :create, :destroy]
  resources :users, :posts
  
  root to: "home#top"
  get "/about", to: "home#about"
  
end
