Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }
  # get '/invite/:invite_token', :to => "members#invite", :as => "invite_confirmation", :only_path => false
  get '/invite/:invite_token', :to => "members#invite", :as => "invite_confirmation", :only_path => false

  get '/dashboard', to: 'home#dashboard', as: 'user_root'

  resources :users, only: [:edit, :update], path: 'profile', as: :profile
  resources :groups, only: [:new, :create, :show, :edit, :update], param: :name do
    resources :members, only: [:new, :index, :create]
  end

  root "home#index"
end
