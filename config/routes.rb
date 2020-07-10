Rails.application.routes.draw do
  get 'users/:id/show' => "users#show"
  get 'users/index' => "users#index"
  get 'users/new' => "users#new"
  post 'users/create' => "users#create"
  post 'users/:id/destroy' => "users#destroy"
  


  get 'posts/:id/show' => "posts#show"
  get 'posts/index' => "posts#index"
  get 'posts/new' => "posts#new"
  post 'posts/create' => "posts#create"
  post 'posts/:id/destroy' => "posts#destroy" 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "about" => "home#about"

end
