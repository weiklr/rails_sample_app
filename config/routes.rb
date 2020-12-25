Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  # This new pattern below routes a GET request for the URL /help
  # to the help action in the Static Pages controller.
  # As with the rule for the root route, this creates two named routes,
  # help_path and help_url:
  get     '/about',       to: 'static_pages#about'
  get     '/help',        to: 'static_pages#help'
  get     '/contact',     to: 'static_pages#contact'
  get     '/signup',      to: 'users#new'

  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'

  # get     '/microposts',  to: 'static_pages#home'
  # generates all GET, POST, PUT, PATCH, DELETE urls
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: %i[new create edit update]
  resources :microposts,          only: %i[create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
