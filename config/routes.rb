Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "deals#home"

  resources :deals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "picks", to: "deals#index", as: "user_picks"
  get "hot_picks", to: "deals#show", as: "hot_picks"
  get "search", to: "deals#search"
end
