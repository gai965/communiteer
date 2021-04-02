Rails.application.routes.draw do
  devise_for :users
  root 'mains#index'
  resources :mains, only: :index
end
