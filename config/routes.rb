Todo::Application.routes.draw do
  get "comments/create"

  devise_for :users

  get "search", controller: "pages"

  resources :tasks do
    get :complete
    get :uncomplete
    get :up
    get :down
    get :like
  end

  resources :companies do
    resources :employees
    resources :projects
    resources :teams
    get :enter
    get :leave, on: :collection
  end

  resources :projects do
    resources :tasks
    resources :managers, only: [:create, :destroy, :index]
  end

  resources :teams do
    resources :members, except: [:show]
  end

  root :to => 'pages#index'
end
