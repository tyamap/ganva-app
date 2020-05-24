Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: %i[create destroy]

    get 'home' => 'top#home', as: :home
    resource :account, only: %i[show edit update]
    resource :profile, only: %i[show edit update]
    resource :password, only: %i[show edit update]
    resources :activities, except: %i[new] do
      collection do
        get 'commit/new', action: 'new_commit'
        get 'result/new', action: 'new_result'
      end
    end
    resources :achievements, only: %i[index show]
    resources :gyms, only: %i[index show]
    resources :relationships, only: %i[create destroy]

    resources :users do
      resources :activities,    only: %i[index show]
      resources :achievements,  only: %i[index show]
      member do
        get :following, :followers
      end
    end
  end
end
