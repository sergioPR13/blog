Rails.application.routes.draw do
  
  resources :categories
  resources :articles do
    resources :comments, only: [:create,:destroy,:update,:show]
  end
  devise_for :users

  root 'welcome#index'

  get"/dashboard", to: "welcome#dashboard"
  put"/articles/:id/publish", to: "articles#publish"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
