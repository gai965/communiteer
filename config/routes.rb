Rails.application.routes.draw do
  devise_for :users
  root 'mains#index'
  resources :mains, only: :index

  # ゲストユーザログイン用のルーティング
  post '/mains/guest_sign_in', to: 'mains#guest_sign_in'
end
