Rails.application.routes.draw do
  devise_for :users
  
  post 'comments/:post_id/create' => "comments#create"
  post 'comments/:comment_id/destroy' => "comments#destroy"
  post 'comments/:comment_id/user_come_destroy/' => "comments#user_come_destroy"
  
  post 'likes/:post_id/create' => "likes#create"
  post 'likes/:post_id/destroy' => "likes#destroy"
  get 'likes/:post_id/index' => "likes#index"
  
  resources :users, :posts
  

  root to: "home#top"
  get "/about", to: "home#about"
  
end
