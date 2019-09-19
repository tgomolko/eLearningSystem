Rails.application.routes.draw do
  resources :courses do
    member do
      patch '/complete', to: 'courses#complete'
    end    
    resources :pages
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

  resources :user_pages, only: :create 
  post 'user_pages/continue'
  #post 'user_courses/:id/complete', to: 'user_courses#complete'
  resources :user_courses, only: [] do
    member do 
      patch :complete
      get :result
    end 
  end
  #patch '/courses/:id/complete', to: 'courses#complete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
