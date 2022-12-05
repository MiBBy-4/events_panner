# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :events

  get 'search', to: 'search#index'  

  resources :event_categories, except: :show

  root 'users/users#show'

  mount Sidekiq::Web, at: '/sidekiq'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
