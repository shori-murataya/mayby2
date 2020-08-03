Rails.application.routes.draw do
  devise_for :users
  post 'comments/:post_id/create' => "comments#create"
  post 'comments/:comment_id/destroy' => "comments#destroy"
  post 'comments/:comment_id/user_come_destroy/' => "comments#user_come_destroy"
  
  post 'likes/:post_id/create' => "likes#create"
  post 'likes/:post_id/destroy' => "likes#destroy"
  get 'likes/:post_id/index' => "likes#index"
  
  get 'users/:id/show' => "users#show"
  get 'users/index' => "users#index"
  
  get 'posts/:id/show' => "posts#show"
  get 'posts/index' => "posts#index"
  get 'posts/new' => "posts#new"
  post 'posts/create' => "posts#create"
  post 'posts/:id/destroy' => "posts#destroy" 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#top"
  get "about" => "home#about"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  
end
