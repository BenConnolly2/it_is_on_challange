Rails.application.routes.draw do
  resources :deals
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "picks", to: "deals#picks", as: "user_picks"
  get "hot_picks", to: "deals#show", as: "hot_picks"
  get "foo", to: "deals#index", as: "all_picks"
  # Defines the root path route ("/")
  root "deals#home"
end
