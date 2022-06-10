# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # stripe webhooks
  mount StripeEvent::Engine, at: '/stripe/webhooks'
  # Defines the root path route ("/")
  root 'assessments#index'
  resources :assessments, only: %i[index show create destroy] do
    resource :quote, only: :update do
      resource :solution, only: %i[create update]
    end
  end
  resources :orders, only: %i[show create] do
    resources :payments, only: :new
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
