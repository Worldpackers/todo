Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  get 'tracking', to: 'trackings#index'
end
