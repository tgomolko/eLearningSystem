Rails.application.routes.draw do
  resources :organizations do 
    member do
      patch :approve
      patch :reject 
    end
  end
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'welcome/index'
  root 'welcome#index'
  get 'admin/dashboard'
  get 'admin/pending_org'
  get 'admin/organizations'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
