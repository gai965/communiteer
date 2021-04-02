Rails.application.routes.draw do
  devise_for :users
  resources :mains, only: :index
end
