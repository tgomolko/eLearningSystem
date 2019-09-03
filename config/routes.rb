Rails.application.routes.draw do
  resources :organizations
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'welcome/index'
  root 'welcome#index'
  get 'users/dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
