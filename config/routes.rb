Rails.application.routes.draw do
  resources :boards do
    get 'bookmarks', on: :collection
    resources :comments, only: %i[create destroy], shallow: true
  end
  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy'
  resources :bookmarks, only: %i[create destroy]
end
