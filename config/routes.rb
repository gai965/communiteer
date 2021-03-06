Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  root 'mains#index'
  resources :mains,         only: :index
  resources :notifications, only: :index
  resources :pages,         only: :show
  resources :volunteers do
    resources :join_volunteers, only: [:index, :new, :create, :show], as: 'join' 
    resources :accepts        , only: [:create]
    resources :cheers         , only: [:index, :create, :destroy]
    collection do
      post 'search'
      post 'detail'
    end
  end
  resources :rooms,   only: [:index, :create] do
    resources :chats, only: [:index, :destroy]
  end

  get '/mains/sign_up_choice', to: 'mains#sign_up_choice'
  get '/mains/sign_in_choice', to: 'mains#sign_in_choice'

  # ボランティア投稿ページへのリダイレクト処理
  get '/volunteers', to: 'volunteers#new'
  post '/volunteers/:id', to: 'volunteers#close', as: 'volunteer_close'

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