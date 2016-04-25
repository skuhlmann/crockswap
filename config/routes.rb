Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  get '/dashboard', to: 'home#dashboard', as: 'user_root'

  resources :users, only: [:edit, :update], path: 'profile', as: :profile

  root "home#index"
end
