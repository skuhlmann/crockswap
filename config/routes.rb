Rails.application.routes.draw do

  namespace :admin do
    resources :users
resources :containers
resources :diet_restrictions
resources :groups
resources :meals
resources :meal_categories
resources :members
resources :reviews
resources :weeks

    root to: "users#index"
  end

  post '/rate' => 'rater#create', :as => 'rate'
  get '/swapboard', to: 'home#swapboard', as: 'user_root'
  get ':group_name/swapboard', to: 'home#swapboard', as: 'group_swapboard'

  get '/invite/:invite_token', :to => "members#invite", :as => "invite_confirmation"
  get 'profile/:id/complete_profile', to: 'users#temporary', as: :complete_profile
  patch 'profile/:id/update_profile', to: 'users#temporary_update', as: :complete_profile_update

  resources :users, only: [:edit, :update], path: 'profile', as: :profile do
    resources :meals, only: [:index, :show]
  end
  resources :groups, only: [:index, :new, :create, :show, :update, :destroy], param: :name do
    resources :members, only: [:new, :index, :create, :destroy, :show]
    resources :weeks, only: [:new, :create, :show, :update] do
      resources :meals, only: [:index, :create, :new, :show, :update]
    end
  end

  resources :meals, only: [] do
    resources :reviews, only: [:create, :update]
  end

  devise_for :users, controllers: { sessions: 'sessions' }

  root "home#index"
end
