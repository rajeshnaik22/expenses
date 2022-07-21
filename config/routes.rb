Rails.application.routes.draw do
  get 'users/index'


  devise_for :users
  resources :photos
  resources :users
   
  root "photos#welcome"
end
