Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :users, only: %i[new create show]
  resources :tasks do
    collection do
      get :search
    end
  end
  resources :sessions, only: %i[new create destroy]
end
