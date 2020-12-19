Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  # This new pattern below routes a GET request for the URL /help 
  # to the help action in the Static Pages controller. 
  # As with the rule for the root route, this creates two named routes, 
  # help_path and help_url:
  get     '/about',   to: 'static_pages#about'
  get     '/help',    to: 'static_pages#help'
  get     '/contact', to: 'static_pages#contact'
  get     '/signup',  to: 'users#new'
  
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  # generates all GET, POST, PUT, PATCH, DELETE urls
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
