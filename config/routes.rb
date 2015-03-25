Yaxt::Application.routes.draw do


  # Default routes to home
  root "pages#home"
  get "/home", to: "pages#home", as: "home"

  # Additions
  resources :entries
  
end
