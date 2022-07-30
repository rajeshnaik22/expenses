Rails.application.routes.draw do
  resources :posts
  get 'users/index'


  devise_for :users
  resources :photos
  resources :users
   
  root "photos#welcome"
end
