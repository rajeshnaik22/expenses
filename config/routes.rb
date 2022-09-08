Rails.application.routes.draw do
  resources :posts
  get 'welcome/index'
  get 'users/index'

  devise_for :users
  resources :photos
  resources :users
  
  authenticated do
    root to: 'photos#index', as: :authenticated_root
  end

  root "welcome#index"

end
