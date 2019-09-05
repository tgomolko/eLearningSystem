Rails.application.routes.draw do
  resources :courses do
    member do
      get '/pages', to: 'pages#index'
      post '/pages', to: 'pages#create'
      get '/pages/new', to: 'pages#new'
      get '/pages/:page_id/edit', to: 'pages#edit'
      get '/pages/:page_id', to: 'pages#show'
      patch '/pages/:page_id', to: 'pages#update'
      delete '/pages/:page_id', to: 'pages#destroy'
    end
  end

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
