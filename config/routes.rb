Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions' }

  root 'mains#index'
  resources :mains, only: :index

  # /usersにリダイレクトの場合「registrattions」のindexアクション
  devise_scope :user do
    get '/users' => 'users/registrations#reject'
  end

  # ゲストユーザログイン用のルーティング
  post '/mains/guest_sign_in', to: 'mains#guest_sign_in'
end
