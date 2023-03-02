Rails.application.routes.draw do
  resources :features
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "picks", to: "features#picks", as: "user_picks"
  get "hot_picks", to: "features#show", as: "hot_picks"
  get "foo", to: "features#index", as: "all_picks"
  # Defines the root path route ("/")
  root "features#home"
end
