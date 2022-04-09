Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root "assessments#index"
  resources :assessments, only:[:index, :create, :destroy] 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
