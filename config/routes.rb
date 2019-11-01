Rails.application.routes.draw do
  get 'comments/index'
  resources :boards, only: %i[index new create show]
  resources :boards do
    resources :comments, except: %i[:edit, :update, :destroy], shallow: true
  end
  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy'
end
