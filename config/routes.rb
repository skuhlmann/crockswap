Rails.application.routes.draw do

  get '/dashboard', to: 'home#dashboard', as: 'user_root'

  get '/invite/:invite_token', :to => "members#invite", :as => "invite_confirmation"
  get 'profile/:id/complete_profile', to: 'users#temporary', as: :complete_profile
  patch 'profile/:id/update_profile', to: 'users#temporary_update', as: :complete_profile_update

  resources :users, only: [:edit, :update], path: 'profile', as: :profile
  resources :groups, only: [:index, :new, :create, :show, :edit, :update], param: :name do
    resources :members, only: [:new, :index, :create, :destroy]
    resources :weeks, only: [:new, :create, :index]
  end
  devise_for :users, controllers: { sessions: 'sessions' }

  root "home#index"
end
