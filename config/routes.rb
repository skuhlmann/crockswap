Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  get '/dashboard', to: 'home#dashboard', as: 'user_root'

  resources :users, only: [:edit, :update], path: 'profile', as: :profile
  resources :groups, only: [:new, :create, :show, :edit, :update], param: :name

  root "home#index"
end
