Rails.application.routes.draw do

  resources :likes
  root 'events#index'

  resources :events do
    resources :registrations
  end

  resource :session, only: [:new, :create, :destroy]

  resources :users
  get 'signup' => 'users#new'

  # get "events/:event_id/registrations", to: "registrations#index"

end
