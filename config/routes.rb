Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :users, expect: %i[edit update]
  resources :tasks do
    collection do
      get :search
    end
  end
end
