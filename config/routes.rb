Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :courses do
    member do
      patch '/complete', to: 'courses#complete'
    end
    resources :pages, except: :index
  end

  resources :organizations do
    member do
      patch :approve
      patch :reject
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :relationships, only: [:create, :destroy]

  get 'welcome/index'
  root 'welcome#index'
  get 'admin/dashboard'
  get 'admin/pending_org'
  get 'admin/organizations'

  post 'questions/add'
  post 'user_answers/create'

  get 'user_dashboard', to: 'user_dashboard#dashboard'
  get 'user_dashboard/current_courses'
  get 'user_dashboard/favorites'
  get 'user_dashboard/last_completed'
  get 'user_dashboard/recomendations'
  get 'user_dashboard/org_courses'
  get 'user_dashboard/courses'
  get 'user_dashboard/my_courses', to: 'user_dashboard#user_courses'
  get 'user_dashboard/my_certificates', to: 'user_dashboard#user_certificates'

  get 'manager_dashboard', to: 'manager_dashboard#dashboard'
  get 'manager_dashboard/organization_courses'

  resources :user_pages, only: :create
  post 'user_pages/continue'

  resources :user_courses, only: [] do
    member do
      patch :complete
      get :result
    end
  end

  resources :course_raitings, only: :create
  resources :bookmarks, only: [:create, :destroy]
  resources :conversations, only: [:index, :show, :destroy] do
     member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]

  post 'import_emails', to: 'email#import'
  get 'manager_dashboard/organization_users'
  #patch '/courses/:id/complete', to: 'courses#complete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
