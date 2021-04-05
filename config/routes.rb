Rails.application.routes.draw do
  root 'mains#index'
  resources :mains, only: :index

  get '/mains/sign_up_choice', to: 'mains#sign_up_choice'
  get '/mains/sign_in_choice', to: 'mains#sign_in_choice'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions' }

  devise_for :groups, controllers: {
    registrations: 'groups/registrations',
    sessions:      'groups/sessions' }
  
  
  devise_scope :user do
    # /usersにリダイレクトの場合「registrattions」のindexアクション
    get '/users' => 'users/registrations#reject'
    # ゲストユーザログイン用のルーティング
    post '/users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  devise_scope :group do
    # /groupsにリダイレクトの場合「registrattions」のindexアクション
    get '/groups' => 'groups/registrations#reject'
    # ゲスト団体ログイン用のルーティング
    post '/groups/guest_sign_in', to: 'groups/sessions#guest_sign_in'
  end

end