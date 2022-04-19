# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root 'assessments#index'
  resources :assessments, only: %i[index show create destroy] do
    resource :quote, only: :update
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
