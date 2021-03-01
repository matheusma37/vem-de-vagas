Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/', to: 'home#index'
  root 'home#index'

  get 'search', to: 'home#search'

  resources :companies, only: %i[edit update], scope: 'admin'
  resources :companies, only: %i[show]

  resources :employees, only: %i[show edit update]
  resources :candidates, only: %i[show edit update]

  resources :job_opportunities, only: %i[show new create edit update] do
    member do
      post :enable
      post :disable
      post :apply
    end
    resources :job_applications, only: %i[show]
  end
end
