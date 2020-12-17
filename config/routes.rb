Rails.application.routes.draw do
  resources :searches
  
  root to: "searches#new"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
