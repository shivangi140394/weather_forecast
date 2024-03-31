Rails.application.routes.draw do
  get 'forecasts/index'

  root 'users#index'

  resources :users do
    resources :forecasts
  end

  get 'verify', to: 'users#verify', as: 'verify'
  post 'verify', to: 'users#verify'
end
