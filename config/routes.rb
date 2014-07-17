Rails.application.routes.draw do

  root 'welcome#index'
  resources :sessions
  resources :users do
    resources :rsvps
  end
  get '/rsvps/new' => 'rsvps#new', as: :new_rsvp
  get '/rsvps/:id' => 'rsvps#show', as: :rsvp
  resources :comments, only: :index
  resources :foods
  resources :stories, only: :index
  resources :photos, only: :index
  resources :wedding_parties, only: :index
  resources :deets, only: :index
  get 'password_resets' => 'password_resets#new'
  put 'password_resets' => 'password_resets#update'

end
