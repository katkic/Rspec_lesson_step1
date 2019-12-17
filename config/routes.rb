Rails.application.routes.draw do
  root to: 'sessions#new'
  namespace :admin do
    resources :users
  end
  resources :users, only: %i[new create show]
  resources :tasks do
    collection do
      get :search
    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :labels
end
