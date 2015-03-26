Yaxt::Application.routes.draw do


  # Default routes to home
  root "pages#home"
  get "/home", to: "pages#home", as: "home"

  # Additions
  resources :entries

  # Custom route for searching
  post '/entries/:id/search', to: 'entries#search'
  
end
