Rails.application.routes.draw do
  resources :boards do
    get 'bookmarks', on: :collection
    resources :comments, only: %i[create update destroy], shallow: true
  end
  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy'
  resources :bookmarks, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  get 'admin', to: 'admin/dashboards#index'
  get 'admin/login', to: 'admin/user_sessions#new'
  post 'admin/login', to: 'admin/user_sessions#create'
  post 'admin/logout', to: 'admin/user_sessions#destroy'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
