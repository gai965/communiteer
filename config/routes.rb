Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions' }

  root 'mains#index'
  resources :mains, only: :index

  
  devise_scope :user do
    # /usersにリダイレクトの場合「registrattions」のindexアクション
    get '/users' => 'users/registrations#reject'

    # ゲストユーザログイン用のルーティング
    post '/users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  
end
