Rails.application.routes.draw do

  resources :users
  root 'events#index'

  resources :events do
    resources :registrations
  end

  # get "events/:event_id/registrations", to: "registrations#index"

end
