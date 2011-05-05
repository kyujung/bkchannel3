Bkchannel3::Application.routes.draw do |map|
  root :to => "sessions#new"
  resources :users
  resources :messages
  resource :session
  resources :seats
  
  match '/login' => "sessions#new", :as => "login"
  match '/logout' => "sessions#destroy", :as => "logout"  
end