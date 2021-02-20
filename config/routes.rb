Rails.application.routes.draw do
  get '/', to: 'home#index'
  root 'home#index'
end
