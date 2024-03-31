Rails.application.routes.draw do
  root 'users#index'

  resources :users 

  get 'verify', to: 'users#verify', as: 'verify'
  post 'verify', to: 'users#verify'
end
