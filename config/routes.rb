Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/', to: 'home#index'
  root 'home#index'

  get 'search', to: 'home#search'

  resources :companies, only: %i[edit update], scope: 'admin'
  resources :companies, only: %i[show]

  resources :employees, only: %i[show]
  resources :candidates, only: %i[show]

  resources :job_opportunities, only: %i[show new create edit update] do
    member do
      post :enable
      post :disable
    end
  end
end
