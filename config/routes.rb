Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/', to: 'home#index'
  root 'home#index'

  resources :companies, only: %i[edit update], scope: 'admin'
  resources :companies, only: %i[show]
end
