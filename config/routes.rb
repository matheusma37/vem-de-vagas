Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/', to: 'home#index'
  root 'home#index'

  get 'search', to: 'home#search'

  resources :companies, only: %i[edit update], scope: 'admin'
  resources :companies, only: %i[show] do
    resources :job_opportunities, only: %i[show new create edit update] do
      member do
        post :enable
        post :disable
        post :apply
      end
      resources :job_applications, only: %i[show] do
        resources :responses, only: %i[] do
          member do
            post :refusal
            post :proposal
          end
        end
      end
    end
  end

  resources :employees, only: %i[show edit update]
  resources :candidates, only: %i[show edit update]
end
