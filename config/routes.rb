Rails.application.routes.draw do
  resources :mains, only: :index
end
