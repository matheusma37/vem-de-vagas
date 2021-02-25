Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get '/', to: 'home#index'
  root 'home#index'

  scope 'admin' do
    resources :companies, only: %i[edit]
  end
end
