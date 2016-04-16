Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  get '/dashboard', to: 'home#dashboard', as: 'user_root'

  root "home#index"
end
