Rails.application.routes.draw do

  get '/swapboard', to: 'home#swapboard', as: 'user_root'
  get ':group_name/swapboard', to: 'home#swapboard', as: 'group_swapboard'

  get '/invite/:invite_token', :to => "members#invite", :as => "invite_confirmation"
  get 'profile/:id/complete_profile', to: 'users#temporary', as: :complete_profile
  patch 'profile/:id/update_profile', to: 'users#temporary_update', as: :complete_profile_update

  post '/groups/:group_name/weeks/:week_id/add_meals', to: 'meals#create_multiple', as: :group_admin_meals

  resources :users, only: [:edit, :update], path: 'profile', as: :profile
  resources :groups, only: [:index, :new, :create, :show, :edit, :update], param: :name do
    resources :members, only: [:new, :index, :create, :destroy]
    resources :weeks, only: [:new, :create, :index, :show, :update] do
      resources :meals, only: [:show, :index, :create, :new, :edit]
    end
  end

  resources :meals, only: [] do
    resources :ratings, only: [:create, :update]
  end

  devise_for :users, controllers: { sessions: 'sessions' }

  root "home#index"
end
